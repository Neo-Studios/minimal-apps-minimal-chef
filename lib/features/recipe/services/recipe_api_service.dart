import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:minimal_chef/features/recipe/models/recipe.dart';

class RecipeApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<Recipe> getRandomRecipe() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final recipe = Recipe.fromMealDb(data['meals'][0]);
      return recipe.toRecipe();
    } else {
      throw Exception('Failed to load random recipe');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        final List<Recipe> recipes = (data['meals'] as List)
            .map((json) => Recipe.fromMealDb(json).toRecipe())
            .toList();
        return recipes;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to search recipes');
    }
  }
}
