import 'package:flutter/material.dart';
import 'package:minimal_chef/models/meal_plan.dart';
import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/services/meal_plan_service.dart';
import 'package:table_calendar/table_calendar.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  DateTime _selectedDay = DateTime.now();

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Meal Plan'),
        content: SizedBox(
          height: 400,
          width: 300,
          child: TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              MealPlanService().addToMealPlan(
                MealPlan(
                  recipeId: widget.recipe.id!,
                  date: _selectedDay,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.recipe.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.recipe.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...widget.recipe.ingredients.map((ingredient) => ListTile(
                  leading: const Icon(Icons.check),
                  title: Text(ingredient.name),
                  subtitle: Text(ingredient.quantity),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...widget.recipe.instructions.asMap().entries.map((entry) => ListTile(
                  leading: CircleAvatar(child: Text('${entry.key + 1}')),
                  title: Text(entry.value),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
