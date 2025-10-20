import 'package:minimal_chef/models/ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> instructions;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
  });
}