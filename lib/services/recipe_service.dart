
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minimal_chef/models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  Future<List<Recipe>> getRecipes() async {
    try {
      final QuerySnapshot snapshot = await _recipesCollection.get();
      return snapshot.docs
          .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error getting recipes: $e');
      return [];
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.add(recipe.toMap());
    } catch (e) {
      print('Error adding recipe: $e');
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _recipesCollection.doc(recipe.id).update(recipe.toMap());
    } catch (e) {
      print('Error updating recipe: $e');
    }
  }

  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _recipesCollection.doc(recipeId).delete();
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }
}
