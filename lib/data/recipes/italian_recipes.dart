import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class ItalianRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Classic Spaghetti Carbonara',
      description: 'A traditional Italian pasta dish with eggs, cheese, and pancetta',
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800',
      instructions: [
        'Bring a large pot of salted water to boil and cook spaghetti according to package directions',
        'While pasta cooks, fry pancetta in a large pan until crispy',
        'In a bowl, whisk together eggs, Parmesan cheese, and black pepper',
        'Drain pasta, reserving 1 cup of pasta water',
        'Add hot pasta to the pan with pancetta, remove from heat',
        'Quickly stir in egg mixture, adding pasta water to create a creamy sauce',
        'Serve immediately with extra Parmesan and black pepper',
      ],
      ingredients: [
        Ingredient(name: 'Spaghetti', quantity: '400g'),
        Ingredient(name: 'Pancetta', quantity: '200g, diced'),
        Ingredient(name: 'Eggs', quantity: '4 large'),
        Ingredient(name: 'Parmesan cheese', quantity: '100g, grated'),
        Ingredient(name: 'Black pepper', quantity: 'to taste'),
        Ingredient(name: 'Salt', quantity: 'to taste'),
      ],
      cuisineType: CuisineType.italian,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 15,
      cookTime: 20,
      servings: 4,
      nutritionInfo: NutritionInfo(
        calories: 650,
        protein: 28,
        carbs: 71,
        fat: 28,
        servingSize: 'Per serving',
      ),
      tags: {'pasta', 'quick', 'eggs'},
    ),
    Recipe(
      name: 'Authentic Margherita Pizza',
      description: 'Traditional Neapolitan pizza with tomatoes, mozzarella, and basil',
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
      instructions: [
        'Preheat oven to 250°C (480°F) with pizza stone',
        'Roll out pizza dough on a floured surface',
        'Spread San Marzano tomato sauce evenly',
        'Add torn buffalo mozzarella pieces',
        'Drizzle with olive oil and season with salt',
        'Bake for 8-10 minutes until crust is charred and cheese is bubbling',
        'Top with fresh basil leaves before serving',
      ],
      ingredients: [
        Ingredient(name: 'Pizza dough', quantity: '250g'),
        Ingredient(name: 'San Marzano tomatoes', quantity: '200g, crushed'),
        Ingredient(name: 'Buffalo mozzarella', quantity: '125g'),
        Ingredient(name: 'Fresh basil', quantity: '10 leaves'),
        Ingredient(name: 'Extra virgin olive oil', quantity: '2 tbsp'),
        Ingredient(name: 'Sea salt', quantity: 'to taste'),
      ],
      cuisineType: CuisineType.italian,
      mealType: MealType.dinner,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 20,
      cookTime: 10,
      servings: 2,
      nutritionInfo: NutritionInfo(
        calories: 450,
        protein: 18,
        carbs: 52,
        fat: 22,
        servingSize: 'Per serving',
      ),
      tags: {'pizza', 'vegetarian', 'classic'},
    ),
    // Add more Italian recipes...
  ];
}