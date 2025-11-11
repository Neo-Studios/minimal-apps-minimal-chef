import Foundation
import FirebaseFirestore

class CookbookService: ObservableObject {
    @Published var cookbooks: [Cookbook] = []
    private let db = Firestore.firestore()
    
    func fetchCookbooks(userId: String) async {
        do {
            let snapshot = try await db.collection("cookbooks")
                .whereField("userId", isEqualTo: userId)
                .getDocuments()
            
            let fetchedCookbooks = snapshot.documents.compactMap { doc -> Cookbook? in
                Cookbook.fromDict(doc.data(), id: doc.documentID)
            }
            
            await MainActor.run {
                self.cookbooks = fetchedCookbooks
            }
        } catch {
            print("Error fetching cookbooks: \(error)")
        }
    }
    
    func addCookbook(_ cookbook: Cookbook) async -> String? {
        do {
            let docRef = try await db.collection("cookbooks").addDocument(data: cookbook.toDict())
            return docRef.documentID
        } catch {
            print("Error adding cookbook: \(error)")
            return nil
        }
    }
    
    func updateCookbook(_ cookbook: Cookbook) async {
        guard let id = cookbook.id else { return }
        
        do {
            try await db.collection("cookbooks").document(id).setData(cookbook.toDict())
        } catch {
            print("Error updating cookbook: \(error)")
        }
    }
    
    func deleteCookbook(id: String) async {
        do {
            try await db.collection("cookbooks").document(id).delete()
            await MainActor.run {
                cookbooks.removeAll { $0.id == id }
            }
        } catch {
            print("Error deleting cookbook: \(error)")
        }
    }
    
    func addRecipeToCookbook(cookbookId: String, recipeId: String) async {
        do {
            let docRef = db.collection("cookbooks").document(cookbookId)
            try await docRef.updateData([
                "recipeIds": FieldValue.arrayUnion([recipeId])
            ])
        } catch {
            print("Error adding recipe to cookbook: \(error)")
        }
    }
}
