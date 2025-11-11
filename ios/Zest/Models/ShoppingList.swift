import Foundation

struct ShoppingListItem: Codable, Identifiable {
    var id: String?
    var name: String
    var amount: String?
    var category: String?
    var checked: Bool
    var recipeId: String?
    var recipeName: String?
    var createdAt: Date
}

enum ShoppingCategory: String, CaseIterable {
    case produce = "Produce"
    case meat = "Meat"
    case dairy = "Dairy"
    case bakery = "Bakery"
    case pantry = "Pantry"
    case frozen = "Frozen"
    case other = "Other"
}
