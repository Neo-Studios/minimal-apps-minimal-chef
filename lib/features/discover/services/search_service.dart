import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:minimal_chef/models/recipe.dart';

class SearchService {
  static late List<Recipe> _recipes;

  static Future<void> init() async {
    final String response = await rootBundle.loadString('lib/data/recipes.neo');
    final List<dynamic> data = json.decode(response);
    _recipes = data.map((json) => Recipe.fromMap(json, '')).toList();
  }

  static List<Recipe> search(String query) {
    if (query.isEmpty) {
      return [];
    }

    final lowerCaseQuery = query.toLowerCase();
    final scoredRecipes = <_ScoredRecipe>[];

    for (final recipe in _recipes) {
      int score = 0;
      final lowerCaseName = recipe.name.toLowerCase();
      final lowerCaseDescription = recipe.description.toLowerCase();

      if (lowerCaseName.contains(lowerCaseQuery)) {
        score += 100;
      }

      if (lowerCaseDescription.contains(lowerCaseQuery)) {
        score += 10;
      }

      for (final ingredient in recipe.ingredients) {
        if (ingredient.name.toLowerCase().contains(lowerCaseQuery)) {
          score += 20;
        }
      }

      // Fuzzy search part
      if (score == 0) {
        // very simple fuzzy: check for matching starting characters
        if (lowerCaseName.startsWith(lowerCaseQuery.substring(0, (lowerCaseQuery.length / 2).round()))) {
          score += 5;
        }
      }

      if (score > 0) {
        scoredRecipes.add(_ScoredRecipe(recipe, score));
      }
    }

    scoredRecipes.sort((a, b) => b.score.compareTo(a.score));

    return scoredRecipes.map((e) => e.recipe).toList();
  }
}

class _ScoredRecipe {
  final Recipe recipe;
  final int score;

  _ScoredRecipe(this.recipe, this.score);
}
