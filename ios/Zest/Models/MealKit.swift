import Foundation
import FirebaseFirestoreSwift

struct MealKit: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var imageUrl: String
    var price: Double
    var recipes: [MealKitRecipe]
    var availableDates: [String] // YYYY-MM-DD
}

struct MealKitRecipe: Codable {
    var recipeId: String
    var servings: Int
}
