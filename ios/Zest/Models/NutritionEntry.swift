import Foundation
import FirebaseFirestore

struct NutritionEntry: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var date: String // ISO date string
    var recipeId: String?
    var recipeName: String
    var servings: Double
    var nutrition: NutritionInfo?
    var createdAt: Date?
}
