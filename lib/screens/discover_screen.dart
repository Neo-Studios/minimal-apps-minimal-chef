import 'package:flutter/material.dart';
import 'package:minimal_chef/models/ingredient.dart';
import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/screens/recipe_detail_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    final List<Recipe> recipes = [
      Recipe(
        id: '1',
        name: 'Spaghetti Carbonara',
        description: 'A classic Italian pasta dish.',
        imageUrl: 'https://www.allrecipes.com/thmb/Vg2c-Airq--2nry1j60G06A5M3A=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/11973-spaghetti-carbonara-ii-DDMFS-4x3-0639-626a3e14676446339f4a2155b1115e58.jpg',
        instructions: [
          'Cook pasta according to package directions.',
          'In a separate bowl, whisk together eggs, cheese, and black pepper.',
          'Drain pasta and immediately toss with the egg mixture.',
          'Serve immediately.'
        ],
        ingredients: [
          Ingredient(name: 'Spaghetti', quantity: '1 lb'),
          Ingredient(name: 'Eggs', quantity: '3'),
          Ingredient(name: 'Parmesan Cheese', quantity: '1 cup'),
          Ingredient(name: 'Black Pepper', quantity: '1 tsp'),
        ],
      ),
      Recipe(
        id: '2',
        name: 'Chicken Tikka Masala',
        description: 'A popular Indian curry dish.',
        imageUrl: 'https://www.allrecipes.com/thmb/1f-fA_h8o15t2n2pXH9A-OF22uY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/45957-chicken-tikka-masala-ddmfs-4x3-0182-3e2b2f7681434c318c86992d9d4f4834.jpg',
        instructions: [
          'Marinate chicken in yogurt and spices.',
          'Grill or pan-fry the chicken.',
          'Prepare the masala sauce.',
          'Simmer the chicken in the sauce.'
        ],
        ingredients: [
          Ingredient(name: 'Chicken Breast', quantity: '1 lb'),
          Ingredient(name: 'Yogurt', quantity: '1 cup'),
          Ingredient(name: 'Garam Masala', quantity: '2 tsp'),
          Ingredient(name: 'Tomato Sauce', quantity: '1 can'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(recipe.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(recipe.name, style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
