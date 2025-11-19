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
}
