import Foundation
import FirebaseFirestore

struct Ingredient: Codable {
    var name: String
    var amount: String
    var unit: String
}

struct Recipe: Codable, Identifiable {
    var id: String?
    var name: String
    var userId: String
    var ingredients: [Ingredient]
    var instructions: [String]
    var prepTime: Int
    var cookTime: Int
    var servings: Int
    var cuisineType: String
    var mealType: String
    var imageUrl: String?
    var createdAt: Date
    var updatedAt: Date
    var isFavorite: Bool = false
    var lastCooked: Date?
    var rating: Int = 0
    
    func toDict() -> [String: Any] {
        return [
            "name": name,
            "userId": userId,
            "ingredients": ingredients.map { ["name": $0.name, "amount": $0.amount, "unit": $0.unit] },
            "instructions": instructions,
            "prepTime": prepTime,
            "cookTime": cookTime,
            "servings": servings,
            "cuisineType": cuisineType,
            "mealType": mealType,
            "imageUrl": imageUrl as Any,
            "createdAt": Timestamp(date: createdAt),
            "updatedAt": Timestamp(date: updatedAt),
            "isFavorite": isFavorite,
            "lastCooked": lastCooked as Any,
            "rating": rating
        ]
    }
}
