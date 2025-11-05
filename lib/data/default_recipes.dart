import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'recipes/italian_recipes.dart';
import 'recipes/asian_recipes.dart';
import 'recipes/indian_recipes.dart';
import 'recipes/mexican_recipes.dart';
import 'recipes/mediterranean_recipes.dart';
import 'recipes/french_recipes.dart';
import 'recipes/american_recipes.dart';
import 'recipes/british_recipes.dart';
import 'recipes/korean_recipes.dart';
import 'recipes/greek_recipes.dart';

class DefaultRecipes {
  static List<Recipe> get recipes => [
    ...ItalianRecipes.recipes,
    ...AsianRecipes.recipes,
    ...IndianRecipes.recipes,
    ...MexicanRecipes.recipes,
    ...MediterraneanRecipes.recipes,
    ...FrenchRecipes.recipes,
    ...AmericanRecipes.recipes,
    ...BritishRecipes.recipes,
    ...KoreanRecipes.recipes,
    ...GreekRecipes.recipes,
  ];
}
