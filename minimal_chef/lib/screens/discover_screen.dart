import 'package:flutter/material.dart';
import 'package:minimal_chef/data/mock_data.dart';
import 'package:minimal_chef/screens/recipe_detail_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockRecipes.length,
      itemBuilder: (context, index) {
        final recipe = mockRecipes[index];
        return ListTile(
          leading: Image.network(recipe.imageUrl),
          title: Text(recipe.name),
          subtitle: Text(recipe.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailScreen(recipe: recipe),
              ),
            );
          },
        );
      },
    );
  }
}
