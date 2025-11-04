import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class AsianRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Sushi Roll (California Roll)',
      description: 'Classic inside-out roll with crab, avocado, and cucumber',
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=800',
      instructions: [
        'Cook sushi rice and season with rice vinegar mixture',
        'Place nori sheet on bamboo mat',
        'Spread rice evenly on nori',
        'Flip over and add fillings in the center',
        'Roll tightly using bamboo mat',
        'Roll in sesame seeds',
        'Cut into 8 pieces and serve',
      ],
      ingredients: [
        Ingredient(name: 'Sushi rice', quantity: '300g'),
        Ingredient(name: 'Nori sheets', quantity: '2'),
        Ingredient(name: 'Crab meat', quantity: '200g'),
        Ingredient(name: 'Avocado', quantity: '1 ripe'),
        Ingredient(name: 'Cucumber', quantity: '1 small'),
        Ingredient(name: 'Rice vinegar', quantity: '3 tbsp'),
        Ingredient(name: 'Sesame seeds', quantity: '4 tbsp'),
      ],
      cuisineType: CuisineType.japanese,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 30,
      cookTime: 20,
      servings: 4,
      nutritionInfo: NutritionInfo(
        calories: 320,
        protein: 12,
        carbs: 45,
        fat: 14,
        servingSize: 'Per serving',
      ),
      tags: {'sushi', 'seafood', 'japanese'},
    ),
    Recipe(
      name: 'Beef and Broccoli Stir Fry',
      description: 'Quick and flavorful Chinese stir-fry with tender beef and crisp broccoli',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800',
      instructions: [
        'Slice beef thinly against the grain',
        'Marinate beef in soy sauce and cornstarch',
        'Blanch broccoli until crisp-tender',
        'Stir-fry beef in hot wok until browned',
        'Add broccoli and sauce mixture',
        'Cook until sauce thickens',
        'Serve hot with rice',
      ],
      ingredients: [
        Ingredient(name: 'Beef sirloin', quantity: '500g'),
        Ingredient(name: 'Broccoli', quantity: '400g'),
        Ingredient(name: 'Soy sauce', quantity: '4 tbsp'),
        Ingredient(name: 'Oyster sauce', quantity: '2 tbsp'),
        Ingredient(name: 'Cornstarch', quantity: '1 tbsp'),
        Ingredient(name: 'Garlic', quantity: '3 cloves'),
        Ingredient(name: 'Ginger', quantity: '2 tbsp, minced'),
      ],
      cuisineType: CuisineType.chinese,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.easy,
      prepTime: 15,
      cookTime: 15,
      servings: 4,
      nutritionInfo: NutritionInfo(
        calories: 380,
        protein: 35,
        carbs: 15,
        fat: 22,
        servingSize: 'Per serving',
      ),
      tags: {'beef', 'stir-fry', 'quick'},
    ),
    // Add more Asian recipes...
  ];
}