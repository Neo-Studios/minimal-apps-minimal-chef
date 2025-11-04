import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class AmericanRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Classic Cheeseburger',
      description: 'Juicy beef patty with melted cheese on a toasted bun',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
      instructions: [
        'Form ground beef into 4 equal patties',
        'Season patties with salt and pepper',
        'Heat grill or pan to medium-high heat',
        'Cook patties 4-5 minutes per side',
        'Add cheese during last minute of cooking',
        'Toast burger buns',
        'Assemble with lettuce, tomato, onion, and condiments',
      ],
      ingredients: [
        Ingredient(name: 'Ground beef (80/20)', quantity: '500g'),
        Ingredient(name: 'Cheese slices', quantity: '4'),
        Ingredient(name: 'Burger buns', quantity: '4'),
        Ingredient(name: 'Lettuce', quantity: '4 leaves'),
        Ingredient(name: 'Tomato', quantity: '1 large'),
        Ingredient(name: 'Red onion', quantity: '1 medium'),
        Ingredient(name: 'Mayonnaise', quantity: 'to taste'),
        Ingredient(name: 'Ketchup', quantity: 'to taste'),
        Ingredient(name: 'Salt and pepper', quantity: 'to taste'),
      ],
      cuisineType: CuisineType.american,
      mealType: MealType.main_course,
      difficultyLevel: DifficultyLevel.easy,
      prepTime: 15,
      cookTime: 10,
      servings: 4,
      nutritionInfo: NutritionInfo(
        calories: 550,
        protein: 32,
        carbs: 35,
        fat: 28,
        servingSize: 'Per serving',
      ),
      tags: {'burger', 'beef', 'grilled', 'sandwich'},
      dietaryRestrictions: {},
    ),
    Recipe(
      name: 'Apple Pie',
      description: 'Classic American apple pie with a flaky butter crust',
      imageUrl: 'https://images.unsplash.com/photo-1621743478914-cc8a86d7e9a5?w=800',
      instructions: [
        'Prepare pie crust and chill',
        'Peel and slice apples',
        'Mix apples with sugar, cinnamon, nutmeg, and lemon juice',
        'Roll out bottom crust and place in pie dish',
        'Add apple filling',
        'Top with second crust, crimp edges, cut vents',
        'Brush with egg wash',
        'Bake at 190°C for 45-50 minutes until golden',
      ],
      ingredients: [
        Ingredient(name: 'All-purpose flour', quantity: '300g'),
        Ingredient(name: 'Cold butter', quantity: '225g'),
        Ingredient(name: 'Ice water', quantity: '120ml'),
        Ingredient(name: 'Apples', quantity: '1kg'),
        Ingredient(name: 'Sugar', quantity: '150g'),
        Ingredient(name: 'Ground cinnamon', quantity: '2 tsp'),
        Ingredient(name: 'Ground nutmeg', quantity: '1/4 tsp'),
        Ingredient(name: 'Lemon juice', quantity: '2 tbsp'),
        Ingredient(name: 'Egg (for wash)', quantity: '1'),
      ],
      cuisineType: CuisineType.american,
      mealType: MealType.dessert,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 45,
      cookTime: 50,
      servings: 8,
      nutritionInfo: NutritionInfo(
        calories: 420,
        protein: 4,
        carbs: 58,
        fat: 20,
        servingSize: 'Per serving',
      ),
      tags: {'dessert', 'pie', 'apple', 'baked'},
      dietaryRestrictions: {DietaryRestriction.vegetarian},
    ),
    // Add more American recipes...
  ];
}