import Foundation

struct SearchFilters {
    var query: String?
    var cuisineType: String?
    var mealType: String?
    var difficulty: String?
    var dietaryRestrictions: [String] = []
    var maxPrepTime: Int?
    var maxCookTime: Int?
    var minRating: Double?
}

class SearchService {
    static let shared = SearchService()
    
    func search(recipes: [Recipe], filters: SearchFilters) -> [Recipe] {
        return recipes.filter { recipe in
            // Query filter
            if let query = filters.query?.lowercased(), !query.isEmpty {
                let matchesName = recipe.name.lowercased().contains(query)
                let matchesIngredients = recipe.ingredients.contains { 
                    $0.name.lowercased().contains(query) 
                }
                if !matchesName && !matchesIngredients {
                    return false
                }
            }
            
            // Cuisine filter
            if let cuisineType = filters.cuisineType, recipe.cuisineType != cuisineType {
                return false
            }
            
            // Meal type filter
            if let mealType = filters.mealType, recipe.mealType != mealType {
                return false
            }
            
            // Difficulty filter
            if let difficulty = filters.difficulty, recipe.difficulty != difficulty {
                return false
            }
            
            // Dietary restrictions filter
            if !filters.dietaryRestrictions.isEmpty {
                let hasAll = filters.dietaryRestrictions.allSatisfy { restriction in
                    recipe.dietaryRestrictions?.contains(restriction) ?? false
                }
                if !hasAll {
                    return false
                }
            }
            
            // Time filters
            if let maxPrepTime = filters.maxPrepTime, let prepTime = recipe.prepTime, prepTime > maxPrepTime {
                return false
            }
            
            if let maxCookTime = filters.maxCookTime, let cookTime = recipe.cookTime, cookTime > maxCookTime {
                return false
            }
            
            // Rating filter
            if let minRating = filters.minRating, let rating = recipe.rating, rating < minRating {
                return false
            }
            
            return true
        }
    }
}
