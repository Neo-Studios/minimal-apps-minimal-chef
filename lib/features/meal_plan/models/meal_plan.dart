import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlan {
  final String? id;
  final String recipeId;
  final DateTime date;

  MealPlan({
    this.id,
    required this.recipeId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipeId': recipeId,
      'date': Timestamp.fromDate(date),
    };
  }

  factory MealPlan.fromMap(Map<String, dynamic> map, String id) {
    return MealPlan(
      id: id,
      recipeId: map['recipeId'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
