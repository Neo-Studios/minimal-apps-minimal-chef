import 'package:minimal_chef/data/recipes/italian_recipes.dart';
import 'package:minimal_chef/data/recipes/indian_recipes.dart';
import 'package:minimal_chef/data/recipes/asian_recipes.dart';
import 'package:minimal_chef/data/recipes/mexican_recipes.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';

class AllRecipes {
  static List<Recipe> get recipes => [
    ...ItalianRecipes.recipes,
    ...IndianRecipes.recipes,
    ...AsianRecipes.recipes,
    ...MexicanRecipes.recipes,
  ];
}