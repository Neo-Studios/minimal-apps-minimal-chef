import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class DevRecipeImportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _recipesCollection = 'recipes';
  final String _duplicatesCollection = 'recipe_hashes';

  Future<void> importRecipesFromGist(String gistUrl, String password) async {
    // Verify password
    final expectedPassword = dotenv.env['DEV_RECIPE_PASSWORD'];
    if (expectedPassword == null || password != expectedPassword) {
      throw Exception('Invalid password');
    }

    // Convert GitHub gist URL to raw URL
    final rawUrl = _convertToRawGistUrl(gistUrl);
    
    // Fetch the gist content
    final response = await http.get(Uri.parse(rawUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch gist: ${response.statusCode}');
    }

    // Parse JSON content
    final List<dynamic> recipesJson = json.decode(response.body);
    
    int imported = 0;
    int duplicates = 0;
    
    for (final recipeData in recipesJson) {
      try {
        final recipe = _parseRecipeFromJson(recipeData);
        final isDuplicate = await _checkForDuplicate(recipe);
        
        if (!isDuplicate) {
          await _addRecipeWithHash(recipe);
          imported++;
          debugPrint('✓ Imported: ${recipe.name}');
        } else {
          duplicates++;
          debugPrint('⚠ Duplicate skipped: ${recipe.name}');
        }
      } catch (e) {
        debugPrint('✗ Error importing recipe: $e');
      }
    }
    
    debugPrint('\n📊 Import Summary:');
    debugPrint('   Imported: $imported recipes');
    debugPrint('   Duplicates skipped: $duplicates recipes');
  }

  String _convertToRawGistUrl(String gistUrl) {
    // Convert https://gist.github.com/user/gistid to raw URL
    final uri = Uri.parse(gistUrl);
    final pathSegments = uri.pathSegments;
    
    if (pathSegments.length >= 2) {
      final gistId = pathSegments.last;
      return 'https://gist.githubusercontent.com/${pathSegments[pathSegments.length - 2]}/$gistId/raw/';
    }
    
    throw Exception('Invalid gist URL format');
  }

  Recipe _parseRecipeFromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      instructions: List<String>.from(json['instructions'] ?? []),
      ingredients: (json['ingredients'] as List?)
          ?.map((i) => Ingredient(
                name: i['name'] ?? '',
                quantity: i['quantity'] ?? '',
              ))
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

  Future<bool> _checkForDuplicate(Recipe recipe) async {
    final hash = _generateRecipeHash(recipe);
    
    try {
      final doc = await _db.collection(_duplicatesCollection).doc(hash).get();
      return doc.exists;
    } catch (e) {
      debugPrint('Error checking for duplicate: $e');
      return false;
    }
  }

  String _generateRecipeHash(Recipe recipe) {
    // Create a unique hash based on recipe name and key ingredients
    final content = '${recipe.name.toLowerCase()}_${recipe.ingredients.take(3).map((i) => i.name.toLowerCase()).join('_')}';
    final bytes = utf8.encode(content);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _addRecipeWithHash(Recipe recipe) async {
    final hash = _generateRecipeHash(recipe);
    
    // Use a batch to ensure both operations succeed or fail together
    final batch = _db.batch();
    
    // Add recipe
    final recipeRef = _db.collection(_recipesCollection).doc();
    batch.set(recipeRef, recipe.toMap());
    
    // Add hash for duplicate detection
    final hashRef = _db.collection(_duplicatesCollection).doc(hash);
    batch.set(hashRef, {
      'recipeId': recipeRef.id,
      'recipeName': recipe.name,
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    await batch.commit();
  }
}