import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/data/recipes.dart';
import 'package:minimal_chef/data/sync_operation.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        instructions TEXT NOT NULL,
        ingredients TEXT NOT NULL,
        userId TEXT,
        cuisineType TEXT NOT NULL DEFAULT 'CuisineType.other',
        mealType TEXT NOT NULL DEFAULT 'MealType.other',
        difficultyLevel TEXT NOT NULL DEFAULT 'DifficultyLevel.easy',
        dietaryRestrictions TEXT NOT NULL DEFAULT '[]',
        tags TEXT NOT NULL DEFAULT '[]',
        prepTime INTEGER NOT NULL DEFAULT 0,
        cookTime INTEGER NOT NULL DEFAULT 0,
        servings INTEGER NOT NULL DEFAULT 4,
        nutritionInfo TEXT,
        source TEXT,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sync_operations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        recipeId TEXT NOT NULL,
        operation TEXT NOT NULL,
        createdAt INTEGER NOT NULL
      )
    ''');
    await _seedDefaultRecipes(db);
  }

  Future _seedDefaultRecipes(Database db) async {
    for (final recipe in AllRecipes.recipes) {
      await db.insert('recipes', {
        'name': recipe.name,
        'description': recipe.description,
        'imageUrl': recipe.imageUrl,
        'instructions': jsonEncode(recipe.instructions),
        'ingredients': jsonEncode(recipe.ingredients.map((i) => i.toMap()).toList()),
        'userId': recipe.userId,
        'cuisineType': recipe.cuisineType.toString(),
        'mealType': recipe.mealType.toString(),
        'difficultyLevel': recipe.difficultyLevel.toString(),
        'dietaryRestrictions': jsonEncode(recipe.dietaryRestrictions.map((r) => r.toString()).toList()),
        'tags': jsonEncode(recipe.tags.toList()),
        'prepTime': recipe.prepTime,
        'cookTime': recipe.cookTime,
        'servings': recipe.servings,
        'nutritionInfo': recipe.nutritionInfo != null ? jsonEncode(recipe.nutritionInfo!.toMap()) : null,
        'source': recipe.source,
        'notes': recipe.notes,
      });
    }
  }

  Future<int> insertRecipe(Recipe recipe) async {
    final db = await database;
    return await db.insert(
      'recipes',
      {
        'name': recipe.name,
        'description': recipe.description,
        'imageUrl': recipe.imageUrl,
        'instructions': jsonEncode(recipe.instructions),
        'ingredients': jsonEncode(recipe.ingredients.map((i) => i.toMap()).toList()),
        'userId': recipe.userId,
        'cuisineType': recipe.cuisineType.toString(),
        'mealType': recipe.mealType.toString(),
        'difficultyLevel': recipe.difficultyLevel.toString(),
        'dietaryRestrictions': jsonEncode(recipe.dietaryRestrictions.map((r) => r.toString()).toList()),
        'tags': jsonEncode(recipe.tags.toList()),
        'prepTime': recipe.prepTime,
        'cookTime': recipe.cookTime,
        'servings': recipe.servings,
        'nutritionInfo': recipe.nutritionInfo != null ? jsonEncode(recipe.nutritionInfo!.toMap()) : null,
        'source': recipe.source,
        'notes': recipe.notes,
      },
    );
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final result = await db.query('recipes');
    return result.map((map) => _recipeFromMap(map)).toList();
  }

  Future<Recipe?> getRecipe(int id) async {
    final db = await database;
    final result = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return _recipeFromMap(result.first);
  }

  Future<int> updateRecipe(Recipe recipe) async {
    final db = await database;
    return await db.update(
      'recipes',
      {
        'name': recipe.name,
        'description': recipe.description,
        'imageUrl': recipe.imageUrl,
        'instructions': jsonEncode(recipe.instructions),
        'ingredients': jsonEncode(recipe.ingredients.map((i) => i.toMap()).toList()),
        'userId': recipe.userId,
        'cuisineType': recipe.cuisineType.toString(),
        'mealType': recipe.mealType.toString(),
        'difficultyLevel': recipe.difficultyLevel.toString(),
        'dietaryRestrictions': jsonEncode(recipe.dietaryRestrictions.map((r) => r.toString()).toList()),
        'tags': jsonEncode(recipe.tags.toList()),
        'prepTime': recipe.prepTime,
        'cookTime': recipe.cookTime,
        'servings': recipe.servings,
        'nutritionInfo': recipe.nutritionInfo != null ? jsonEncode(recipe.nutritionInfo!.toMap()) : null,
        'source': recipe.source,
        'notes': recipe.notes,
      },
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Recipe>> searchRecipes(String query,
      {CuisineType? cuisineType,
      MealType? mealType,
      DifficultyLevel? difficultyLevel,
      Set<DietaryRestriction>? dietaryRestrictions,
      Set<String>? tags,
      int? maxPrepTime,
      int? maxCookTime}) async {
    final db = await database;
    
    List<String> conditions = ['(name LIKE ? OR description LIKE ?)'];
    List<dynamic> args = ['%$query%', '%$query%'];

    if (cuisineType != null) {
      conditions.add('cuisineType = ?');
      args.add(cuisineType.toString());
    }
    if (mealType != null) {
      conditions.add('mealType = ?');
      args.add(mealType.toString());
    }
    if (difficultyLevel != null) {
      conditions.add('difficultyLevel = ?');
      args.add(difficultyLevel.toString());
    }
    if (maxPrepTime != null) {
      conditions.add('prepTime <= ?');
      args.add(maxPrepTime);
    }
    if (maxCookTime != null) {
      conditions.add('cookTime <= ?');
      args.add(maxCookTime);
    }

    final result = await db.query(
      'recipes',
      where: conditions.join(' AND '),
      whereArgs: args,
    );

    final recipes = result.map((map) => _recipeFromMap(map)).toList();

    // Post-process filtering for complex filters
    if (dietaryRestrictions != null && dietaryRestrictions.isNotEmpty) {
      recipes.removeWhere((recipe) =>
          !dietaryRestrictions.every((r) => recipe.dietaryRestrictions.contains(r)));
    }
    if (tags != null && tags.isNotEmpty) {
      recipes.removeWhere((recipe) => !tags.every((t) => recipe.tags.contains(t)));
    }

    return recipes;
  }

  Recipe _recipeFromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      instructions: List<String>.from(jsonDecode(map['instructions'])),
      ingredients: (jsonDecode(map['ingredients']) as List)
          .map((i) => Ingredient.fromMap(i))
          .toList(),
      userId: map['userId'],
      cuisineType: CuisineType.values.firstWhere(
        (e) => e.toString() == map['cuisineType'],
        orElse: () => CuisineType.other,
      ),
      mealType: MealType.values.firstWhere(
        (e) => e.toString() == map['mealType'],
        orElse: () => MealType.other,
      ),
      difficultyLevel: DifficultyLevel.values.firstWhere(
        (e) => e.toString() == map['difficultyLevel'],
        orElse: () => DifficultyLevel.easy,
      ),
      dietaryRestrictions: (jsonDecode(map['dietaryRestrictions'] ?? '[]') as List)
          .map((r) => DietaryRestriction.values.firstWhere(
              (e) => e.toString() == r,
              orElse: () => DietaryRestriction.none))
          .toSet(),
      tags: Set<String>.from(jsonDecode(map['tags'] ?? '[]')),
      prepTime: map['prepTime']?.toInt() ?? 0,
      cookTime: map['cookTime']?.toInt() ?? 0,
      servings: map['servings']?.toInt() ?? 4,
      nutritionInfo: map['nutritionInfo'] != null
          ? NutritionInfo.fromMap(jsonDecode(map['nutritionInfo']))
          : null,
      source: map['source'],
      notes: map['notes'],
    );
  }

  // Sync Operations
  Future<void> addSyncOperation(String recipeId, SyncOperation operation) async {
    final db = await database;
    await db.insert('sync_operations', {
      'recipeId': recipeId,
      'operation': operation.toString(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<SyncOperation>> getPendingSyncOperations() async {
    final db = await database;
    final result = await db.query(
      'sync_operations',
      orderBy: 'createdAt ASC',
    );
    return result.map((map) => SyncOperation.fromMap(map)).toList();
  }

  Future<void> removeSyncOperation(int id) async {
    final db = await database;
    await db.delete(
      'sync_operations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
