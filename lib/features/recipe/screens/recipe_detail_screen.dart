import 'package:flutter/material.dart';
import 'package:minimal_chef/features/meal_plan/models/meal_plan.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/meal_plan/services/meal_plan_service.dart';
import 'package:minimal_chef/features/common/widgets/instruction_step.dart';
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
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final theme = Theme.of(context);
          return AlertDialog(
            title: const Text('Add to Meal Plan'),
            content: SizedBox(
              width: double.maxFinite,
              child: TableCalendar(
                focusedDay: _selectedDay,
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setDialogState(() {
                    _selectedDay = selectedDay;
                  });
                },
                headerStyle: HeaderStyle(
                  titleTextStyle: theme.textTheme.titleLarge!,
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to your meal plan!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        label: const Text('Add to Plan'),
        icon: const Icon(Icons.calendar_today_outlined),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.recipe.name, style: theme.textTheme.titleLarge),
              background: Image.network(
                widget.recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.description,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Ingredients', theme),
                  const SizedBox(height: 16),
                  _buildIngredientsList(theme),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Instructions', theme),
                  const SizedBox(height: 16),
                  _buildInstructionsList(theme),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildIngredientsList(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: widget.recipe.ingredients
            .map((ingredient) => ListTile(
                  leading: Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
                  title: Text(ingredient.name),
                  subtitle: ingredient.quantity != null ? Text(ingredient.quantity!) : null,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildInstructionsList(ThemeData theme) {
    return Column(
      children: widget.recipe.instructions
          .asMap()
          .entries
          .map((entry) => InstructionStep(
                stepNumber: entry.key + 1,
                instruction: entry.value,
              ))
          .toList(),
    );
  }
}
