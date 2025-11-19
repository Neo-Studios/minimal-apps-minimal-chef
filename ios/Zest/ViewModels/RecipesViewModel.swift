import Foundation
import FirebaseAuth

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let recipeService = RecipeService()
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        }
        return recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            recipes = try await recipeService.getRecipes(userId: Auth.auth().currentUser?.uid ?? "")
        } catch {
            print("Error loading recipes: \(error)")
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func toggleFavorite(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
            Task {
                await recipeService.updateRecipe(recipes[index])
            }
        }
    }

    func updateRating(recipeId: String, rating: Double) async {
        if let index = recipes.firstIndex(where: { $0.id == recipeId }) {
            recipes[index].rating = Int(rating)
            await recipeService.updateRecipe(recipes[index])
        }
    }

    func deleteRecipe(id: String) async -> Bool {
        do {
            try await recipeService.deleteRecipe(id: id)
            recipes.removeAll { $0.id == id }
            return true
        } catch {
            print("Error deleting recipe: \(error)")
            errorMessage = error.localizedDescription
            return false
        }
    }
}
