import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_chef/features/meal_plan/models/meal_plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('MealPlan Model', () {
    test('creates meal plan with required fields', () {
      final date = DateTime(2025, 1, 15);
      final mealPlan = MealPlan(
        recipeId: 'recipe123',
        date: date,
      );

      expect(mealPlan.recipeId, 'recipe123');
      expect(mealPlan.date, date);
      expect(mealPlan.id, null);
    });

    test('toMap converts meal plan to map', () {
      final date = DateTime(2025, 1, 20);
      final mealPlan = MealPlan(
        id: 'plan123',
        recipeId: 'recipe456',
        date: date,
      );

      final map = mealPlan.toMap();

      expect(map['recipeId'], 'recipe456');
      expect(map['date'], isA<Timestamp>());
    });

    test('fromMap creates meal plan from map', () {
      final date = DateTime(2025, 2, 1);
      final map = {
        'recipeId': 'recipe789',
        'date': Timestamp.fromDate(date),
      };

      final mealPlan = MealPlan.fromMap(map, 'plan456');

      expect(mealPlan.id, 'plan456');
      expect(mealPlan.recipeId, 'recipe789');
      expect(mealPlan.date.year, 2025);
      expect(mealPlan.date.month, 2);
      expect(mealPlan.date.day, 1);
    });
  });
}
