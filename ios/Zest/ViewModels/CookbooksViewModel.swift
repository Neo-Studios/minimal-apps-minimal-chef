import Foundation
import FirebaseAuth

@MainActor
class CookbooksViewModel: ObservableObject {
    @Published var cookbooks: [Cookbook] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let firebaseService = FirebaseService.shared
    
    func loadCookbooks() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            cookbooks = try await firebaseService.getCookbooks(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func createCookbook(name: String, description: String?, isPublic: Bool = false) async -> Bool {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return false
        }
        
        let cookbook = Cookbook(
            name: name,
            description: description,
            recipeIds: [],
            userId: userId,
            isPublic: isPublic,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        do {
            let _ = try await firebaseService.createCookbook(cookbook)
            await loadCookbooks()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func updateCookbook(id: String, name: String, description: String?, isPublic: Bool) async -> Bool {
        guard let index = cookbooks.firstIndex(where: { $0.id == id }) else {
            errorMessage = "Cookbook not found"
            return false
        }
        
        var cookbook = cookbooks[index]
        cookbook.name = name
        cookbook.description = description
        cookbook.isPublic = isPublic
        cookbook.updatedAt = Date()
        
        do {
            try await firebaseService.updateCookbook(id: id, cookbook)
            await loadCookbooks()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func deleteCookbook(id: String) async -> Bool {
        do {
            try await firebaseService.deleteCookbook(id: id)
            await loadCookbooks()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func addRecipeToCookbook(cookbookId: String, recipeId: String) async -> Bool {
        do {
            try await firebaseService.addRecipeToCookbook(cookbookId: cookbookId, recipeId: recipeId)
            await loadCookbooks()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func removeRecipeFromCookbook(cookbookId: String, recipeId: String) async -> Bool {
        do {
            try await firebaseService.removeRecipeFromCookbook(cookbookId: cookbookId, recipeId: recipeId)
            await loadCookbooks()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
