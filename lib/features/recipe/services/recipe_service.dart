import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';

class RecipeService {
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  Future<List<Recipe>> getRecipes() async {
    try {
      final QuerySnapshot snapshot = await _recipesCollection.get();
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final recipeWithUser = Recipe(
        id: recipe.id,
        name: recipe.name,
        description: recipe.description,
        imageUrl: recipe.imageUrl,
        instructions: recipe.instructions,
        ingredients: recipe.ingredients,
        userId: userId,
      );
      await _recipesCollection.add(recipeWithUser.toMap());
    } catch (e) {
      debugPrint("Error adding recipe: $e");
      rethrow;
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.doc(recipe.id).update(recipe.toMap());
    } catch (e) {
      debugPrint("Error updating recipe: $e");
      rethrow;
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _recipesCollection.doc(recipeId).delete();
    } catch (e) {
      debugPrint("Error deleting recipe: $e");
      rethrow;
    }
  }
}
