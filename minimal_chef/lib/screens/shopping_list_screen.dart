import 'package:flutter/material.dart';
import 'package:minimal_chef/data/mock_data.dart';
import 'package:minimal_chef/models/ingredient.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = mockRecipes
        .expand((recipe) => recipe.ingredients)
        .fold<Map<String, Ingredient>>({}, (map, ingredient) {
      if (map.containsKey(ingredient.name)) {
        // For simplicity, we're just adding quantities as strings.
        // A more robust solution would require parsing and combining units.
        map[ingredient.name] = Ingredient(
          name: ingredient.name,
          quantity: '${map[ingredient.name]!.quantity}, ${ingredient.quantity}',
        );
      } else {
        map[ingredient.name] = ingredient;
      }
      return map;
    }).values.toList();

    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return ListTile(
          title: Text(ingredient.name),
          subtitle: Text(ingredient.quantity),
        );
      },
    );
  }
}
