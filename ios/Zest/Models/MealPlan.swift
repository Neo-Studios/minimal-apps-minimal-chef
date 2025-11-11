import Foundation

struct MealPlanEntry: Codable {
    var recipeId: String
    var recipeName: String
    var mealType: String
}

struct MealPlan: Codable {
    var date: String
    var meals: [MealPlanEntry]
}
