import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class FrenchRecipes {
  static List<Recipe> get recipes => [
    Recipe(
      name: 'Coq au Vin',
      description: 'Classic French braised chicken in red wine sauce',
      imageUrl: 'https://images.unsplash.com/photo-1600891965050-6da6bad77c3f?w=800',
      instructions: [
        'Pat chicken pieces dry and season with salt and pepper',
        'Brown chicken in butter and oil until golden',
        'Remove chicken and sauté bacon, mushrooms, and pearl onions',
        'Add garlic and tomato paste',
        'Return chicken to pot and add red wine and stock',
        'Simmer covered for 1 hour until chicken is tender',
        'Thicken sauce with beurre manié if desired',
        'Garnish with fresh parsley',
      ],
      ingredients: [
        Ingredient(name: 'Chicken pieces', quantity: '1.5 kg'),
        Ingredient(name: 'Bacon lardons', quantity: '200g'),
        Ingredient(name: 'Pearl onions', quantity: '12'),
        Ingredient(name: 'Mushrooms', quantity: '300g'),
        Ingredient(name: 'Red wine', quantity: '750ml'),
        Ingredient(name: 'Chicken stock', quantity: '500ml'),
        Ingredient(name: 'Butter', quantity: '50g'),
        Ingredient(name: 'Garlic', quantity: '4 cloves'),
        Ingredient(name: 'Fresh thyme', quantity: '4 sprigs'),
        Ingredient(name: 'Bay leaves', quantity: '2'),
      ],
      cuisineType: CuisineType.french,
      mealType: MealType.main_course,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 30,
      cookTime: 90,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 450,
        protein: 35,
        carbs: 8,
        fat: 28,
        servingSize: 'Per serving',
      ),
      tags: {'chicken', 'wine', 'braised', 'classic'},
      dietaryRestrictions: {},
    ),
    Recipe(
      name: 'Crème Brûlée',
      description: 'Rich vanilla custard with caramelized sugar top',
      imageUrl: 'https://images.unsplash.com/photo-1587314168485-3236d6710814?w=800',
      instructions: [
        'Heat cream with vanilla bean and pod',
        'Whisk egg yolks with sugar until pale',
        'Slowly temper hot cream into egg mixture',
        'Strain and pour into ramekins',
        'Bake in water bath at 150°C for 35 minutes',
        'Chill for at least 4 hours',
        'Sprinkle with sugar and caramelize with torch',
        'Let caramel harden before serving',
      ],
      ingredients: [
        Ingredient(name: 'Heavy cream', quantity: '500ml'),
        Ingredient(name: 'Vanilla bean', quantity: '1'),
        Ingredient(name: 'Egg yolks', quantity: '6'),
        Ingredient(name: 'Sugar', quantity: '100g'),
        Ingredient(name: 'Extra sugar for topping', quantity: '60g'),
      ],
      cuisineType: CuisineType.french,
      mealType: MealType.dessert,
      difficultyLevel: DifficultyLevel.intermediate,
      prepTime: 20,
      cookTime: 35,
      servings: 6,
      nutritionInfo: NutritionInfo(
        calories: 380,
        protein: 4,
        carbs: 25,
        fat: 30,
        servingSize: 'Per serving',
      ),
      tags: {'dessert', 'custard', 'vanilla', 'classic'},
      dietaryRestrictions: {DietaryRestriction.gluten_free},
    ),
    // Add more French recipes...
  ];
}