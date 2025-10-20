import 'package:flutter/material.dart';
import 'package:minimal_chef/data/mock_data.dart';
import 'package:minimal_chef/models/meal_plan.dart';
import 'package:minimal_chef/screens/recipe_detail_screen.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final mockMealPlan = MealPlan(
    date: DateTime.now(),
    recipes: [mockRecipes[0]],
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Calendar View (placeholder)
        SizedBox(
          height: 100,
          child: Center(
            child: Text(
              'Calendar View',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        // Recipe List
        Expanded(
          child: ListView.builder(
            itemCount: mockMealPlan.recipes.length,
            itemBuilder: (context, index) {
              final recipe = mockMealPlan.recipes[index];
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
          ),
        ),
      ],
    );
  }
}
