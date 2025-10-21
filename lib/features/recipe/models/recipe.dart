import 'package:minimal_chef/features/recipe/models/ingredient.dart';

class Recipe {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> instructions;
  final List<Ingredient> ingredients;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'instructions': instructions,
      'ingredients': ingredients.map((i) => i.toMap()).toList(),
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      instructions: List<String>.from(map['instructions'] ?? []),
      ingredients: (map['ingredients'] as List?)
              ?.map((i) => Ingredient.fromMap(i))
              .toList() ??
          [],
    );
  }

  factory Recipe.fromMealDb(Map<String, dynamic> map) {
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = map['strIngredient$i'];
      final measure = map['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(Ingredient(name: ingredient, quantity: measure));
      } else {
        break;
      }
    }

    return Recipe(
      id: map['idMeal'],
      name: map['strMeal'] ?? '',
      description: map['strInstructions'] ?? '',
      imageUrl: map['strMealThumb'] ?? '',
      instructions: (map['strInstructions'] as String? ?? '').split('\r\n').where((s) => s.isNotEmpty).toList(),
      ingredients: ingredients,
    );
  }

  Recipe toRecipe() {
    return Recipe(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      instructions: instructions,
      ingredients: ingredients,
    );
  }
}
