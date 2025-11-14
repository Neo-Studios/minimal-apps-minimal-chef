import Foundation
import FirebaseFirestore

class RecipeService {
    static let shared = RecipeService()
    private let db = Firestore.firestore()
    private let recipesCollection = "recipes"
    
    private init() {}
    
    func addRecipe(_ recipe: Recipe) async throws -> String {
        let docRef = try await db.collection(recipesCollection).addDocument(data: recipe.toDict())
        return docRef.documentID
    }
    
    func getRecipes(userId: String) async throws -> [Recipe] {
        let snapshot = try await db.collection(recipesCollection)
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Recipe.self)
        }
    }
    
    func updateRecipe(id: String, data: [String: Any]) async throws {
        try await db.collection(recipesCollection).document(id).updateData(data)
    }
    
    func deleteRecipe(id: String) async throws {
        try await db.collection(recipesCollection).document(id).delete()
    }
}
