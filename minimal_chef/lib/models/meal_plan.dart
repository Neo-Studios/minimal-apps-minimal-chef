import 'package:minimal_chef/models/recipe.dart';

class MealPlan {
  final DateTime date;
  final List<Recipe> recipes;

  MealPlan({
    required this.date,
    required this.recipes,
  });
}