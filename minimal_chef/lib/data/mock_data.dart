'''import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/models/ingredient.dart';

final mockRecipes = [
  Recipe(
    id: '1',
    name: 'Spaghetti Carbonara',
    description: 'A classic Italian pasta dish.',
    imageUrl: 'https://www.allrecipes.com/thmb/Vg2GXE_3Ftr35_1IuC9_Lu42_gA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/11973-spaghetti-carbonara-ii-DDMFS-4x3-0618-d6b2c4f8784b4347963240a6142c8b82.jpg',
    instructions: [
      'Cook pasta according to package directions.',
      'Meanwhile, cook bacon in a large skillet over medium heat until crisp.',
      'In a small bowl, whisk together eggs and Parmesan cheese.',
      'Drain pasta and add to skillet with bacon.',
      'Remove from heat and stir in egg mixture.',
      'Serve immediately.'
    ],
    ingredients: [
      Ingredient(name: 'Spaghetti', quantity: '1 lb'),
      Ingredient(name: 'Bacon', quantity: '8 slices'),
      Ingredient(name: 'Eggs', quantity: '2'),
      Ingredient(name: 'Parmesan cheese', quantity: '1/2 cup'),
    ],
  ),
  Recipe(
    id: '2',
    name: 'Chicken Tikka Masala',
    description: 'A popular Indian curry dish.',
    imageUrl: 'https://www.seriouseats.com/thmb/Db9GGR2X2t2Nn_2fjs39f_1N1iA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140ef9ac1f49f69205da8.JPG',
    instructions: [
      'In a large bowl, combine chicken, yogurt, and spices.',
      'Marinate for at least 1 hour.',
      'Grill or broil chicken until cooked through.',
      'In a large saucepan, heat oil over medium heat.',
      'Sauté onions until tender.',
      'Stir in tomato sauce and cream.',
      'Add chicken and simmer for 15 minutes.',
      'Serve with rice.'
    ],
    ingredients: [
      Ingredient(name: 'Chicken', quantity: '1 lb'),
      Ingredient(name: 'Yogurt', quantity: '1 cup'),
      Ingredient(name: 'Spices', quantity: '2 tbsp'),
      Ingredient(name: 'Onion', quantity: '1'),
      Ingredient(name: 'Tomato sauce', quantity: '1 can'),
      Ingredient(name: 'Cream', quantity: '1/2 cup'),
      Ingredient(name: 'Rice', quantity: '2 cups'),
    ],
  ),
];
''