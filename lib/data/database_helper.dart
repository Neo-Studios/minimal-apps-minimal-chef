import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/data/default_recipes.dart';

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
        userId TEXT
      )
    ''');
    await _seedDefaultRecipes(db);
  }

  Future _seedDefaultRecipes(Database db) async {
    for (final recipe in DefaultRecipes.recipes) {
      await db.insert('recipes', {
        'name': recipe.name,
        'description': recipe.description,
        'imageUrl': recipe.imageUrl,
        'instructions': jsonEncode(recipe.instructions),
        'ingredients': jsonEncode(recipe.ingredients.map((i) => i.toMap()).toList()),
        'userId': recipe.userId,
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

  Future<List<Recipe>> searchRecipes(String query) async {
    final db = await database;
    final result = await db.query(
      'recipes',
      where: 'name LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result.map((map) => _recipeFromMap(map)).toList();
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
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
