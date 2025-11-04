import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class MexicanRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Authentic Guacamole',
      description: 'Fresh and creamy Mexican dip made with ripe avocados',
      imageUrl: 'https://images.unsplash.com/photo-1541288892379-c987c60cd049?w=800',
      instructions: [
        'Mash avocados in a bowl',
        'Finely chop onion, tomato, and cilantro',
        'Mix in lime juice and chopped ingredients',
        'Season with salt and cumin',
        'Add diced jalapeño for heat if desired',
        'Let rest for 30 minutes for flavors to meld',
        'Serve with tortilla chips',
      ],
      ingredients: [
        Ingredient(name: 'Ripe avocados', quantity: '3'),
        Ingredient(name: 'Lime', quantity: '1'),
        Ingredient(name: 'Red onion', quantity: '1/2, finely chopped'),
        Ingredient(name: 'Tomato', quantity: '1 medium'),
        Ingredient(name: 'Fresh cilantro', quantity: '1/4 cup'),
        Ingredient(name: 'Jalapeño', quantity: '1 (optional)'),
        Ingredient(name: 'Salt', quantity: 'to taste'),
        Ingredient(name: 'Ground cumin', quantity: '1/4 tsp'),
      ],
      cuisineType: CuisineType.mexican,
      mealType: MealType.appetizer,
      difficultyLevel: DifficultyLevel.easy,
      prepTime: 15,
      cookTime: 0,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 150,
        protein: 2,
        carbs: 9,
        fat: 13,
        servingSize: 'Per serving',
      ),
      tags: {'appetizer', 'vegetarian', 'vegan', 'dip'},
      dietaryRestrictions: {DietaryRestriction.vegan, DietaryRestriction.gluten_free},
    ),
    Recipe(
      name: 'Street Tacos Al Pastor',
      description: 'Traditional Mexican pork tacos with pineapple',
      imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=800',
      instructions: [
        'Marinate pork in achiote paste and spices overnight',
        'Stack marinated pork on vertical spit with pineapple',
        'Cook slowly, turning and slicing outer layer as it cooks',
        'Warm corn tortillas',
        'Fill tortillas with meat and diced pineapple',
        'Top with onions, cilantro, and lime',
        'Serve with salsa of choice',
      ],
      ingredients: [
        Ingredient(name: 'Pork shoulder', quantity: '1kg'),
        Ingredient(name: 'Achiote paste', quantity: '100g'),
        Ingredient(name: 'Pineapple', quantity: '1'),
        Ingredient(name: 'Corn tortillas', quantity: '24 small'),
        Ingredient(name: 'White onion', quantity: '1'),
        Ingredient(name: 'Cilantro', quantity: '1 bunch'),
        Ingredient(name: 'Limes', quantity: '4'),
      ],
      cuisineType: CuisineType.mexican,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.advanced,
      prepTime: 30,
      cookTime: 180,
      servings: 8,
      nutritionInfo: NutritionInfo(
        calories: 420,
        protein: 28,
        carbs: 35,
        fat: 22,
        servingSize: 'Per serving (3 tacos)',
      ),
      tags: {'pork', 'tacos', 'street food', 'spicy'},
    ),
    // Add more Mexican recipes...
  ];
}