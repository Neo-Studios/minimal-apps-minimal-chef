import Foundation

class ShoppingListGenerator {
    func generate(from recipes: [Recipe]) -> [Ingredient] {
        var ingredientMap: [String: Ingredient] = [:]
        
        for recipe in recipes {
            for ingredient in recipe.ingredients {
                let key = ingredient.name.lowercased()
                if let existing = ingredientMap[key] {
                    ingredientMap[key] = Ingredient(
                        name: existing.name,
                        amount: "\(existing.amount) + \(ingredient.amount)",
                        unit: existing.unit
                    )
                } else {
                    ingredientMap[key] = ingredient
                }
            }
        }
        
        return Array(ingredientMap.values)
    }
}
