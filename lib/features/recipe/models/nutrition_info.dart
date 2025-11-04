class NutritionInfo {
  final int calories;
  final double protein;    // grams
  final double carbs;      // grams
  final double fat;        // grams
  final double fiber;      // grams
  final double sugar;      // grams
  final int sodium;        // milligrams
  final String servingSize;

  NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber = 0,
    this.sugar = 0,
    this.sodium = 0,
    required this.servingSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'servingSize': servingSize,
    };
  }

  factory NutritionInfo.fromMap(Map<String, dynamic> map) {
    return NutritionInfo(
      calories: map['calories']?.toInt() ?? 0,
      protein: map['protein']?.toDouble() ?? 0.0,
      carbs: map['carbs']?.toDouble() ?? 0.0,
      fat: map['fat']?.toDouble() ?? 0.0,
      fiber: map['fiber']?.toDouble() ?? 0.0,
      sugar: map['sugar']?.toDouble() ?? 0.0,
      sodium: map['sodium']?.toInt() ?? 0,
      servingSize: map['servingSize'] ?? 'Not specified',
    );
  }
}