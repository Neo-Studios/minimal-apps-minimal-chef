import Foundation

struct NutritionInfo: Codable {
    let calories: Int
    let protein: Double
    let carbs: Double
    let fat: Double
}

class NutritionCalculator {
    static let shared = NutritionCalculator()
    
    private let nutritionDatabase: [String: NutritionInfo] = [
        "chicken breast": NutritionInfo(calories: 165, protein: 31, carbs: 0, fat: 3.6),
        "rice": NutritionInfo(calories: 130, protein: 2.7, carbs: 28, fat: 0.3),
        "broccoli": NutritionInfo(calories: 55, protein: 3.7, carbs: 11, fat: 0.6),
        "olive oil": NutritionInfo(calories: 884, protein: 0, carbs: 0, fat: 100),
        "egg": NutritionInfo(calories: 155, protein: 13, carbs: 1.1, fat: 11),
        "milk": NutritionInfo(calories: 61, protein: 3.2, carbs: 4.8, fat: 3.3),
        "bread": NutritionInfo(calories: 265, protein: 9, carbs: 49, fat: 3.2),
        "pasta": NutritionInfo(calories: 131, protein: 5, carbs: 25, fat: 1.1),
        "tomato": NutritionInfo(calories: 18, protein: 0.9, carbs: 3.9, fat: 0.2),
        "cheese": NutritionInfo(calories: 402, protein: 25, carbs: 1.3, fat: 33)
    ]
    
    func calculate(ingredients: [Ingredient], servings: Int) -> NutritionInfo {
        var totalCalories = 0.0
        var totalProtein = 0.0
        var totalCarbs = 0.0
        var totalFat = 0.0
        
        for ingredient in ingredients {
            if let nutrition = nutritionDatabase[ingredient.name.lowercased()] {
                let factor = ingredient.amount / 100.0
                totalCalories += Double(nutrition.calories) * factor
                totalProtein += nutrition.protein * factor
                totalCarbs += nutrition.carbs * factor
                totalFat += nutrition.fat * factor
            }
        }
        
        return NutritionInfo(
            calories: Int(totalCalories / Double(servings)),
            protein: round(totalProtein / Double(servings) * 10) / 10,
            carbs: round(totalCarbs / Double(servings) * 10) / 10,
            fat: round(totalFat / Double(servings) * 10) / 10
        )
    }
    
    func estimateCost(ingredients: [Ingredient]) -> Double {
        return round(Double(ingredients.count) * 2.5 * 100) / 100
    }
}
