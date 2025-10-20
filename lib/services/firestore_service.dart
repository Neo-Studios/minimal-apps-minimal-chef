import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minimal_chef/models/recipe.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRecipe(Recipe recipe) {
    return _db.collection('recipes').add(recipe.toMap());
  }

  Stream<List<Recipe>> getRecipes() {
    return _db.collection('recipes').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList());
  }

  Future<Recipe> getRecipeById(String id) {
    return _db.collection('recipes').doc(id).get().then((doc) => Recipe.fromMap(doc.data()!, doc.id));
  }
}
