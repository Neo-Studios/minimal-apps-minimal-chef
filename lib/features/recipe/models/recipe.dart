import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/nutrition_info.dart';
import 'package:minimal_chef/features/recipe/models/recipe_enums.dart';

class Recipe {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> instructions;
  final List<Ingredient> ingredients;
  final String? userId;
  
  // New fields
  final CuisineType cuisineType;
  final MealType mealType;
  final DifficultyLevel difficultyLevel;
  final Set<DietaryRestriction> dietaryRestrictions;
  final Set<String> tags;
  final int prepTime;       // in minutes
  final int cookTime;       // in minutes
  final int servings;
  final NutritionInfo? nutritionInfo;
  final String? source;     // URL or reference
  final String? notes;      // Additional tips or variations

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
    this.userId,
    this.cuisineType = CuisineType.other,
    this.mealType = MealType.other,
    this.difficultyLevel = DifficultyLevel.easy,
    this.dietaryRestrictions = const {},
    this.tags = const {},
    this.prepTime = 0,
    this.cookTime = 0,
    this.servings = 4,
    this.nutritionInfo,
    this.source,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'instructions': instructions,
      'ingredients': ingredients.map((i) => i.toMap()).toList(),
      'userId': userId,
      'cuisineType': cuisineType.toString(),
      'mealType': mealType.toString(),
      'difficultyLevel': difficultyLevel.toString(),
      'dietaryRestrictions': dietaryRestrictions.map((r) => r.toString()).toList(),
      'tags': tags.toList(),
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'nutritionInfo': nutritionInfo?.toMap(),
      'source': source,
      'notes': notes,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      instructions: List<String>.from(map['instructions'] ?? []),
      ingredients: (map['ingredients'] as List?)
          ?.map((i) => Ingredient.fromMap(i))
          .toList() ??
          [],
      userId: map['userId'],
      cuisineType: map['cuisineType'] != null
          ? CuisineType.values.firstWhere(
              (e) => e.toString() == map['cuisineType'],
              orElse: () => CuisineType.other)
          : CuisineType.other,
      mealType: map['mealType'] != null
          ? MealType.values.firstWhere(
              (e) => e.toString() == map['mealType'],
              orElse: () => MealType.other)
          : MealType.other,
      difficultyLevel: map['difficultyLevel'] != null
          ? DifficultyLevel.values.firstWhere(
              (e) => e.toString() == map['difficultyLevel'],
              orElse: () => DifficultyLevel.easy)
          : DifficultyLevel.easy,
      dietaryRestrictions: (map['dietaryRestrictions'] as List?)
          ?.map((r) => DietaryRestriction.values.firstWhere(
              (e) => e.toString() == r,
              orElse: () => DietaryRestriction.none))
          .toSet() ??
          {},
      tags: Set<String>.from(map['tags'] ?? []),
      prepTime: map['prepTime']?.toInt() ?? 0,
      cookTime: map['cookTime']?.toInt() ?? 0,
      servings: map['servings']?.toInt() ?? 4,
      nutritionInfo: map['nutritionInfo'] != null
          ? NutritionInfo.fromMap(map['nutritionInfo'])
          : null,
      source: map['source'],
      notes: map['notes'],
    );
  }

  factory Recipe.fromMealDb(Map<String, dynamic> map) {
    List<Ingredient> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = map['strIngredient$i'];
      final measure = map['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(Ingredient(name: ingredient, quantity: measure));
      } else {
        break;
      }
    }

    // Try to determine cuisine type from category or area
    CuisineType determineCuisineType(String? area, String? category) {
      if (area != null) {
        switch (area.toLowerCase()) {
          case 'italian':
            return CuisineType.italian;
          case 'indian':
            return CuisineType.indian;
          case 'mexican':
            return CuisineType.mexican;
          case 'chinese':
            return CuisineType.chinese;
          case 'japanese':
            return CuisineType.japanese;
          case 'thai':
            return CuisineType.thai;
          case 'french':
            return CuisineType.french;
          case 'greek':
            return CuisineType.greek;
          default:
            return CuisineType.other;
        }
      }
      return CuisineType.other;
    }

    // Try to determine meal type from category
    MealType determineMealType(String? category) {
      if (category != null) {
        switch (category.toLowerCase()) {
          case 'breakfast':
            return MealType.breakfast;
          case 'dessert':
            return MealType.dessert;
          case 'starter':
            return MealType.appetizer;
          case 'side':
            return MealType.side_dish;
          case 'beef':
          case 'chicken':
          case 'lamb':
          case 'pork':
          case 'seafood':
            return MealType.dinner;
          default:
            return MealType.other;
        }
      }
      return MealType.other;
    }

    return Recipe(
      id: map['idMeal'],
      name: map['strMeal'] ?? '',
      description: map['strInstructions'] ?? '',
      imageUrl: map['strMealThumb'] ?? '',
      instructions: (map['strInstructions'] as String? ?? '')
          .split('\r\n')
          .where((s) => s.isNotEmpty)
          .toList(),
      ingredients: ingredients,
      cuisineType: determineCuisineType(map['strArea'], map['strCategory']),
      mealType: determineMealType(map['strCategory']),
      userId: null,
      tags: {map['strTags'] ?? ''}.where((t) => t.isNotEmpty).toSet(),
    );
  }

  Recipe toRecipe() {
    return Recipe(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      instructions: instructions,
      ingredients: ingredients,
      userId: userId,
      cuisineType: cuisineType,
      mealType: mealType,
      difficultyLevel: difficultyLevel,
      dietaryRestrictions: dietaryRestrictions,
      tags: tags,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      nutritionInfo: nutritionInfo,
      source: source,
      notes: notes,
    );
  }

  int get totalTime => prepTime + cookTime;

  bool get isVegetarian => dietaryRestrictions.contains(DietaryRestriction.vegetarian);
  bool get isVegan => dietaryRestrictions.contains(DietaryRestriction.vegan);
  bool get isGlutenFree => dietaryRestrictions.contains(DietaryRestriction.gluten_free);
  bool get isDairyFree => dietaryRestrictions.contains(DietaryRestriction.dairy_free);
}
