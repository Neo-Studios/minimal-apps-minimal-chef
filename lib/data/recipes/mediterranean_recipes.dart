import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class MediterraneanRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Greek Salad',
      description: 'Fresh and crisp traditional Greek salad with feta cheese',
      imageUrl: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=800',
      instructions: [
        'Chop tomatoes, cucumber, and red onion',
        'Add Kalamata olives',
        'Cut feta cheese into cubes',
        'Combine vegetables and cheese in a bowl',
        'Drizzle with olive oil and red wine vinegar',
        'Season with dried oregano, salt, and pepper',
        'Toss gently and serve',
      ],
      ingredients: [
        Ingredient(name: 'Tomatoes', quantity: '4 large'),
        Ingredient(name: 'Cucumber', quantity: '1 large'),
        Ingredient(name: 'Red onion', quantity: '1 medium'),
        Ingredient(name: 'Kalamata olives', quantity: '100g'),
        Ingredient(name: 'Feta cheese', quantity: '200g'),
        Ingredient(name: 'Extra virgin olive oil', quantity: '4 tbsp'),
        Ingredient(name: 'Red wine vinegar', quantity: '2 tbsp'),
        Ingredient(name: 'Dried oregano', quantity: '1 tsp'),
      ],
      cuisineType: CuisineType.mediterranean,
      mealType: MealType.side_dish,
      difficultyLevel: DifficultyLevel.beginner,
      prepTime: 15,
      cookTime: 0,
      servings: 4,
      nutritionInfo: NutritionInfo(
        calories: 280,
        protein: 8,
        carbs: 12,
        fat: 22,
        servingSize: 'Per serving',
      ),
      tags: {'salad', 'vegetarian', 'fresh', 'no-cook'},
      dietaryRestrictions: {DietaryRestriction.gluten_free},
    ),
    Recipe(
      name: 'Hummus',
      description: 'Creamy Middle Eastern dip made with chickpeas and tahini',
      imageUrl: 'https://images.unsplash.com/photo-1577223625816-7546c8dfb8d1?w=800',
      instructions: [
        'Drain and rinse chickpeas',
        'Process chickpeas in food processor until smooth',
        'Add tahini, lemon juice, and garlic',
        'Process while drizzling in olive oil',
        'Season with salt and cumin',
        'Add water if needed for desired consistency',
        'Serve drizzled with olive oil and paprika',
      ],
      ingredients: [
        Ingredient(name: 'Chickpeas', quantity: '400g can'),
        Ingredient(name: 'Tahini', quantity: '60ml'),
        Ingredient(name: 'Lemon juice', quantity: '60ml'),
        Ingredient(name: 'Garlic', quantity: '2 cloves'),
        Ingredient(name: 'Olive oil', quantity: '60ml'),
        Ingredient(name: 'Ground cumin', quantity: '1 tsp'),
        Ingredient(name: 'Salt', quantity: 'to taste'),
        Ingredient(name: 'Paprika', quantity: 'for garnish'),
      ],
      cuisineType: CuisineType.mediterranean,
      mealType: MealType.appetizer,
      difficultyLevel: DifficultyLevel.easy,
      prepTime: 10,
      cookTime: 0,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 180,
        protein: 6,
        carbs: 15,
        fat: 12,
        servingSize: 'Per serving',
      ),
      tags: {'dip', 'vegetarian', 'vegan', 'chickpeas'},
      dietaryRestrictions: {DietaryRestriction.vegan, DietaryRestriction.gluten_free},
    ),
    // Add more Mediterranean recipes...
  ];
}