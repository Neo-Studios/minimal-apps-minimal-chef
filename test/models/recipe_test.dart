import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

void main() {
  group('Recipe Model', () {
    test('creates recipe with required fields', () {
      final recipe = Recipe(
        name: 'Test Recipe',
        description: 'Test description',
        imageUrl: 'https://example.com/image.jpg',
        instructions: ['Step 1', 'Step 2'],
        ingredients: [Ingredient(name: 'Flour', quantity: '2 cups')],
      );

      expect(recipe.name, 'Test Recipe');
      expect(recipe.description, 'Test description');
      expect(recipe.instructions.length, 2);
      expect(recipe.ingredients.length, 1);
    });

    test('toMap converts recipe to map', () {
      final recipe = Recipe(
        name: 'Pasta',
        description: 'Italian pasta',
        imageUrl: 'url',
        instructions: ['Boil water'],
        ingredients: [Ingredient(name: 'Pasta', quantity: '200g')],
        userId: 'user123',
        prepTime: 10,
        cookTime: 20,
        servings: 4,
      );

      final map = recipe.toMap();

      expect(map['name'], 'Pasta');
      expect(map['userId'], 'user123');
      expect(map['prepTime'], 10);
      expect(map['cookTime'], 20);
      expect(map['servings'], 4);
    });

    test('fromMap creates recipe from map', () {
      final map = {
        'name': 'Pizza',
        'description': 'Delicious pizza',
        'imageUrl': 'url',
        'instructions': ['Make dough', 'Add toppings'],
        'ingredients': [
          {'name': 'Dough', 'quantity': '1'}
        ],
        'prepTime': 30,
        'cookTime': 15,
      };

      final recipe = Recipe.fromMap(map, 'recipe123');

      expect(recipe.id, 'recipe123');
      expect(recipe.name, 'Pizza');
      expect(recipe.prepTime, 30);
      expect(recipe.cookTime, 15);
    });

    test('totalTime calculates correctly', () {
      final recipe = Recipe(
        name: 'Test',
        description: 'Test',
        imageUrl: 'url',
        instructions: [],
        ingredients: [],
        prepTime: 15,
        cookTime: 30,
      );

      expect(recipe.totalTime, 45);
    });

    test('dietary restriction checks work', () {
      final recipe = Recipe(
        name: 'Salad',
        description: 'Vegan salad',
        imageUrl: 'url',
        instructions: [],
        ingredients: [],
        dietaryRestrictions: {DietaryRestriction.vegan, DietaryRestriction.gluten_free},
      );

      expect(recipe.isVegan, true);
      expect(recipe.isGlutenFree, true);
      expect(recipe.isVegetarian, false);
    });
  });
}
