import Foundation
import FirebaseAuth

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    
    private let recipeService = RecipeService()
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        }
        return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadRecipes() async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        do {
            recipes = try await recipeService.getRecipes(userId: userId)
        } catch {
            print("Error loading recipes: \(error)")
        }
    }
}
