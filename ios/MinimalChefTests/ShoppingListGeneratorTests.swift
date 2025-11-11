import XCTest
@testable import MinimalChef

class ShoppingListGeneratorTests: XCTestCase {
    
    func testCombinesDuplicateIngredients() {
        let generator = ShoppingListGenerator()
        let recipes = [
            Recipe(name: "Recipe 1", userId: "1", ingredients: [Ingredient(name: "flour", amount: "2", unit: "cups")], instructions: [], prepTime: 10, cookTime: 20, servings: 4, cuisineType: "italian", mealType: "dinner", createdAt: Date(), updatedAt: Date()),
            Recipe(name: "Recipe 2", userId: "1", ingredients: [Ingredient(name: "flour", amount: "1", unit: "cup")], instructions: [], prepTime: 10, cookTime: 20, servings: 4, cuisineType: "italian", mealType: "dinner", createdAt: Date(), updatedAt: Date())
        ]
        
        let result = generator.generate(from: recipes)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "flour")
    }
}
