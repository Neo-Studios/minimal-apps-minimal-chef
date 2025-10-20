import 'package:minimal_chef/models/ingredient.dart';

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

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? instructions,
    List<Ingredient>? ingredients,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      instructions: instructions ?? this.instructions,
      ingredients: ingredients ?? this.ingredients,
    );
  }
}
