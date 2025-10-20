import 'package:flutter/material.dart';
import 'package:minimal_chef/models/meal_plan.dart';
import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/services/firestore_service.dart';
import 'package:minimal_chef/services/meal_plan_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final MealPlanService _mealPlanService = MealPlanService();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<List<MealPlan>>(
              stream: _mealPlanService.getMealPlan(
                _selectedDay,
                _selectedDay.add(const Duration(days: 1)),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No meals planned for this day.'));
                }

                final mealPlans = snapshot.data!;

                return ListView.builder(
                  itemCount: mealPlans.length,
                  itemBuilder: (context, index) {
                    final mealPlan = mealPlans[index];
                    return FutureBuilder<Recipe>(
                      future: _firestoreService.getRecipeById(mealPlan.recipeId),
                      builder: (context, recipeSnapshot) {
                        if (recipeSnapshot.connectionState == ConnectionState.waiting) {
                          return const ListTile(title: Text('Loading...'));
                        }
                        if (recipeSnapshot.hasError) {
                          return ListTile(title: Text('Error: ${recipeSnapshot.error}'));
                        }
                        if (!recipeSnapshot.hasData) {
                          return const ListTile(title: Text('Recipe not found.'));
                        }

                        final recipe = recipeSnapshot.data!;

                        return ListTile(
                          leading: Image.network(recipe.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(recipe.name),
                          subtitle: Text(recipe.description),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
