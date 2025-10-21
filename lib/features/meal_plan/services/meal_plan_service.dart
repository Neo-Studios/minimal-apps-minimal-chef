import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minimal_chef/models/meal_plan.dart';

class MealPlanService {
  final CollectionReference _mealPlanCollection = FirebaseFirestore.instance.collection('meal_plans');

  Future<void> addToMealPlan(MealPlan mealPlan) async {
    await _mealPlanCollection.add(mealPlan.toMap());
  }

  Stream<List<MealPlan>> getMealPlan(DateTime startDate, DateTime endDate) {
    return _mealPlanCollection
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MealPlan.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Stream<List<MealPlan>> getMealPlansForDay(DateTime day) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);
    return getMealPlan(startOfDay, endOfDay);
  }
}
