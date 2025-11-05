// ignore_for_file: constant_identifier_names

enum CuisineType {
  italian,
  indian,
  mexican,
  chinese,
  japanese,
  thai,
  mediterranean,
  american,
  french,
  spanish,
  greek,
  middle_eastern,
  vietnamese,
  korean,
  other
}

enum MealType {
  breakfast,
  brunch,
  lunch,
  dinner,
  snack,
  dessert,
  appetizer,
  side_dish,
  drink,
  sauce,
  other
}

enum DifficultyLevel {
  beginner,
  easy,
  intermediate,
  advanced,
  expert
}

enum DietaryRestriction {
  vegetarian,
  vegan,
  gluten_free,
  dairy_free,
  nut_free,
  kosher,
  halal,
  keto,
  paleo,
  low_carb,
  low_fat,
  pescatarian,
  none
}

extension CuisineTypeExtension on CuisineType {
  String get displayName {
    return toString().split('.').last.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}

extension MealTypeExtension on MealType {
  String get displayName {
    return toString().split('.').last.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get displayName {
    return toString().split('.').last.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  int get cookingTimeEstimate {
    switch (this) {
      case DifficultyLevel.beginner:
        return 15;
      case DifficultyLevel.easy:
        return 30;
      case DifficultyLevel.intermediate:
        return 45;
      case DifficultyLevel.advanced:
        return 60;
      case DifficultyLevel.expert:
        return 90;
    }
  }
}

extension DietaryRestrictionExtension on DietaryRestriction {
  String get displayName {
    return toString().split('.').last.split('_').map((word) => 
      word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}