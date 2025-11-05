import 'dart:convert';
import 'dart:js_interop';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

@JS('importRecipesToFirestore')
external set _importRecipesToFirestore(JSFunction f);

class WebRecipeImportService {
  static const String _devPassword = 'neo-access-[pop]-@chef';
  static const int _maxImportsPerHour = 1000;
  static const int _maxImportsPerDay = 5000;
  static const int _maxRecipesPerFile = 100;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  static final Map<String, List<DateTime>> _importHistory = {};
  static final Map<String, int> _dailyImports = {};
  static String _getClientId() => DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8);

  static void initialize() {
    if (kIsWeb) {
      _importRecipesToFirestore = _handleImport.toJS;
    }
  }

  static void _handleImport(JSAny data) async {
    try {
      final service = WebRecipeImportService();
      final dataObj = data as JSObject;
      final recipesJS = (dataObj as JSAny).dartify() as Map<String, dynamic>;
      
      final recipes = (recipesJS['recipes'] as List).cast<Map<String, dynamic>>();
      final password = recipesJS['password'] as String;
      
      await service._importRecipes(recipes, password);
    } catch (e) {
      debugPrint('Import error: $e');
    }
  }

  Future<void> _importRecipes(List<Map<String, dynamic>> recipesData, String password) async {
    if (password != _devPassword) {
      throw Exception('Invalid password');
    }

    if (recipesData.length > _maxRecipesPerFile) {
      throw Exception('Too many recipes: Max $_maxRecipesPerFile per file');
    }

    final clientId = _getClientId();
    _checkRateLimit(clientId, recipesData.length);

    int imported = 0;
    int duplicates = 0;
    int skipped = 0;

    for (final recipeData in recipesData) {
      try {
        final recipe = _parseRecipe(recipeData);
        final hash = _generateHash(recipe);
        
        final hashDoc = await _db.collection('recipe_hashes').doc(hash).get();
        
        if (!hashDoc.exists) {
          final batch = _db.batch();
          final recipeRef = _db.collection('recipes').doc();
          
          batch.set(recipeRef, recipe.toMap());
          batch.set(_db.collection('recipe_hashes').doc(hash), {
            'recipeId': recipeRef.id,
            'recipeName': recipe.name,
            'hash': hash,
            'createdAt': FieldValue.serverTimestamp(),
          });
          
          await batch.commit();
          imported++;
          debugPrint('✓ ${recipe.name}');
        } else {
          final existingRecipeId = hashDoc.data()?['recipeId'];
          final existingRecipe = await _db.collection('recipes').doc(existingRecipeId).get();
          
          if (existingRecipe.exists) {
            duplicates++;
            debugPrint('⚠ Duplicate kept original: ${recipe.name}');
          } else {
            skipped++;
            debugPrint('⚠ Hash exists but recipe missing: ${recipe.name}');
          }
        }
      } catch (e) {
        debugPrint('✗ Error: $e');
      }
    }
    
    _recordImport(clientId, imported);
    debugPrint('Imported: $imported, Duplicates: $duplicates, Skipped: $skipped');
  }

  Recipe _parseRecipe(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      instructions: List<String>.from(json['instructions'] ?? []),
      ingredients: (json['ingredients'] as List?)
          ?.map((i) => Ingredient(name: i['name'] ?? '', quantity: i['quantity'] ?? ''))
          .toList() ?? [],
      cuisineType: _parseCuisineType(json['cuisineType']),
      mealType: _parseMealType(json['mealType']),
      difficultyLevel: _parseDifficultyLevel(json['difficultyLevel']),
      dietaryRestrictions: _parseDietaryRestrictions(json['dietaryRestrictions']),
      tags: Set<String>.from(json['tags'] ?? []),
      prepTime: json['prepTime']?.toInt() ?? 0,
      cookTime: json['cookTime']?.toInt() ?? 0,
      servings: json['servings']?.toInt() ?? 4,
      nutritionInfo: json['nutritionInfo'] != null
          ? NutritionInfo(
              calories: json['nutritionInfo']['calories']?.toInt() ?? 0,
              protein: json['nutritionInfo']['protein']?.toInt() ?? 0,
              carbs: json['nutritionInfo']['carbs']?.toInt() ?? 0,
              fat: json['nutritionInfo']['fat']?.toInt() ?? 0,
              servingSize: json['nutritionInfo']['servingSize'] ?? 'Per serving',
            )
          : null,
      source: json['source'],
      notes: json['notes'],
    );
  }

  CuisineType _parseCuisineType(String? type) {
    if (type == null) return CuisineType.other;
    return CuisineType.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == type.toLowerCase(),
      orElse: () => CuisineType.other,
    );
  }

  MealType _parseMealType(String? type) {
    if (type == null) return MealType.other;
    return MealType.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == type.toLowerCase(),
      orElse: () => MealType.other,
    );
  }

  DifficultyLevel _parseDifficultyLevel(String? level) {
    if (level == null) return DifficultyLevel.easy;
    return DifficultyLevel.values.firstWhere(
      (e) => e.toString().split('.').last.toLowerCase() == level.toLowerCase(),
      orElse: () => DifficultyLevel.easy,
    );
  }

  Set<DietaryRestriction> _parseDietaryRestrictions(List<dynamic>? restrictions) {
    if (restrictions == null) return {};
    return restrictions
        .map((r) => DietaryRestriction.values.firstWhere(
              (e) => e.toString().split('.').last.toLowerCase() == r.toString().toLowerCase(),
              orElse: () => DietaryRestriction.none,
            ))
        .where((r) => r != DietaryRestriction.none)
        .toSet();
  }

  String _generateHash(Recipe recipe) {
    final content = '${recipe.name.toLowerCase().trim()}_${recipe.ingredients.take(3).map((i) => i.name.toLowerCase().trim()).join('_')}';
    return sha256.convert(utf8.encode(content)).toString();
  }

  void _checkRateLimit(String clientId, int requestCount) {
    final now = DateTime.now();
    final today = '${now.year}-${now.month}-${now.day}';
    
    _importHistory[clientId] ??= [];
    _dailyImports['$clientId-$today'] ??= 0;
    
    final hourlyImports = _importHistory[clientId]!
        .where((time) => now.difference(time).inHours < 1)
        .length;
    
    final dailyImports = _dailyImports['$clientId-$today']!;
    
    if (hourlyImports + requestCount > _maxImportsPerHour) {
      throw Exception('Rate limit: Max $_maxImportsPerHour imports per hour');
    }
    
    if (dailyImports + requestCount > _maxImportsPerDay) {
      throw Exception('Rate limit: Max $_maxImportsPerDay imports per day');
    }
  }
  
  void _recordImport(String clientId, int count) {
    final now = DateTime.now();
    final today = '${now.year}-${now.month}-${now.day}';
    
    for (int i = 0; i < count; i++) {
      _importHistory[clientId]!.add(now);
    }
    
    _dailyImports['$clientId-$today'] = (_dailyImports['$clientId-$today'] ?? 0) + count;
    
    _importHistory[clientId] = _importHistory[clientId]!
        .where((time) => now.difference(time).inHours < 24)
        .toList();
  }
}