// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _recipesCollection = 'recipes';

  // Add a new recipe
  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _db.collection(_recipesCollection).add(recipe.toMap());
    } catch (e) {
      print('Error adding recipe to Firestore: $e');
      rethrow;
    }
  }

  // Update an existing recipe
  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _db.collection(_recipesCollection).doc(recipe.id).update(recipe.toMap());
    } catch (e) {
      print('Error updating recipe in Firestore: $e');
      rethrow;
    }
  }

  // Delete a recipe
  Future<void> deleteRecipe(String id) async {
    try {
      await _db.collection(_recipesCollection).doc(id).delete();
    } catch (e) {
      print('Error deleting recipe from Firestore: $e');
      rethrow;
    }
  }

  // Get a recipe by ID
  Future<Recipe> getRecipeById(String id) async {
    try {
      final doc = await _db.collection(_recipesCollection).doc(id).get();
      if (!doc.exists) {
        throw Exception('Recipe not found');
      }
      return Recipe.fromMap(doc.data()!, doc.id);
    } catch (e) {
      print('Error getting recipe from Firestore: $e');
      rethrow;
    }
  }

  // Get all recipes (can be used for full sync)
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final snapshot = await _db.collection(_recipesCollection).get();
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error getting all recipes from Firestore: $e');
      rethrow;
    }
  }

  // Get recipes as a stream (for real-time updates)
  Stream<List<Recipe>> getRecipesStream() {
    return _db.collection(_recipesCollection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList());
  }

  // Advanced search with filters
  Future<List<Recipe>> searchRecipes({
    String? query,
    CuisineType? cuisineType,
    MealType? mealType,
    DifficultyLevel? difficultyLevel,
    Set<DietaryRestriction>? dietaryRestrictions,
    Set<String>? tags,
    int? maxPrepTime,
    int? maxCookTime,
  }) async {
    try {
      Query recipesQuery = _db.collection(_recipesCollection);

      if (cuisineType != null) {
        recipesQuery = recipesQuery.where('cuisineType', isEqualTo: cuisineType.toString());
      }
      if (mealType != null) {
        recipesQuery = recipesQuery.where('mealType', isEqualTo: mealType.toString());
      }
      if (difficultyLevel != null) {
        recipesQuery = recipesQuery.where('difficultyLevel', isEqualTo: difficultyLevel.toString());
      }
      if (maxPrepTime != null) {
        recipesQuery = recipesQuery.where('prepTime', isLessThanOrEqualTo: maxPrepTime);
      }
      if (maxCookTime != null) {
        recipesQuery = recipesQuery.where('cookTime', isLessThanOrEqualTo: maxCookTime);
      }

      final snapshot = await recipesQuery.get();
      List<Recipe> recipes = snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      // Apply additional filters that can't be done in the query
      if (query != null && query.isNotEmpty) {
        final lowerQuery = query.toLowerCase();
        recipes = recipes
            .where((recipe) =>
                recipe.name.toLowerCase().contains(lowerQuery) ||
                recipe.description.toLowerCase().contains(lowerQuery))
            .toList();
      }

      if (dietaryRestrictions != null && dietaryRestrictions.isNotEmpty) {
        recipes = recipes
            .where((recipe) => dietaryRestrictions
                .every((r) => recipe.dietaryRestrictions.contains(r)))
            .toList();
      }

      if (tags != null && tags.isNotEmpty) {
        recipes = recipes
            .where((recipe) => tags.every((t) => recipe.tags.contains(t)))
            .toList();
      }

      return recipes;
    } catch (e) {
      print('Error searching recipes in Firestore: $e');
      rethrow;
    }
  }
}
