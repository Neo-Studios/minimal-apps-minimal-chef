import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class IndianRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Butter Chicken',
      description: 'Rich and creamy Indian curry with tender chicken pieces in a tomato-based sauce',
      imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800',
      instructions: [
        'Marinate chicken in yogurt, lemon juice, and spices for 4 hours',
        'In a large pan, sauté onions until golden brown',
        'Add ginger-garlic paste and cook until fragrant',
        'Add tomato puree and spices, simmer for 10 minutes',
        'Add marinated chicken and cook until done',
        'Stir in butter and cream',
        'Garnish with coriander and serve with naan',
      ],
      ingredients: [
        Ingredient(name: 'Chicken thighs', quantity: '800g, boneless'),
        Ingredient(name: 'Yogurt', quantity: '200g'),
        Ingredient(name: 'Butter', quantity: '100g'),
        Ingredient(name: 'Heavy cream', quantity: '200ml'),
        Ingredient(name: 'Tomato puree', quantity: '400g'),
        Ingredient(name: 'Onions', quantity: '2 large'),
        Ingredient(name: 'Ginger-garlic paste', quantity: '2 tbsp'),
        Ingredient(name: 'Garam masala', quantity: '2 tsp'),
        Ingredient(name: 'Kashmiri red chili powder', quantity: '1 tsp'),
        Ingredient(name: 'Kasoori methi', quantity: '1 tbsp'),
      ],
      cuisineType: CuisineType.indian,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 30,
      cookTime: 45,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 550,
        protein: 35,
        carbs: 12,
        fat: 42,
        servingSize: 'Per serving',
      ),
      tags: {'curry', 'chicken', 'creamy'},
    ),
    Recipe(
      name: 'Dal Makhani',
      description: 'Creamy black lentils simmered overnight with spices',
      imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800',
      instructions: [
        'Soak black lentils and kidney beans overnight',
        'Pressure cook lentils and beans until soft',
        'In a pan, sauté onions, ginger, and garlic',
        'Add tomato puree and spices',
        'Add cooked lentils and simmer for 30 minutes',
        'Add butter and cream',
        'Garnish with cream and serve with naan',
      ],
      ingredients: [
        Ingredient(name: 'Black lentils', quantity: '300g'),
        Ingredient(name: 'Kidney beans', quantity: '50g'),
        Ingredient(name: 'Butter', quantity: '100g'),
        Ingredient(name: 'Cream', quantity: '200ml'),
        Ingredient(name: 'Tomato puree', quantity: '300g'),
        Ingredient(name: 'Onion', quantity: '2 medium'),
        Ingredient(name: 'Ginger paste', quantity: '1 tbsp'),
        Ingredient(name: 'Garlic paste', quantity: '1 tbsp'),
        Ingredient(name: 'Garam masala', quantity: '1 tsp'),
      ],
      cuisineType: CuisineType.indian,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 20,
      cookTime: 60,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 380,
        protein: 15,
        carbs: 42,
        fat: 18,
        servingSize: 'Per serving',
      ),
      tags: {'vegetarian', 'lentils', 'creamy'},
    ),
    // Add more Indian recipes...
  ];
}