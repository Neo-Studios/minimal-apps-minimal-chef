import Foundation
import FirebaseAuth

@MainActor
class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let firebaseService = FirebaseService.shared
    
    var uncheckedItems: [ShoppingItem] {
        items.filter { !$0.checked }
    }
    
    var checkedItems: [ShoppingItem] {
        items.filter { $0.checked }
    }
    
    func loadItems() async {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            items = try await firebaseService.getShoppingList(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func addItem(name: String, quantity: String, category: String?) async -> Bool {
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "User not authenticated"
            return false
        }
        
        let finalCategory = category?.isEmpty ?? true ? ShoppingListCategorizer.categorize(itemName: name) : category
        
        let item = ShoppingItem(
            userId: userId,
            name: name,
            quantity: quantity,
            category: finalCategory,
            checked: false,
            createdAt: Date()
        )
        
        do {
            let _ = try await firebaseService.addShoppingItem(item)
            await loadItems()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func toggleItem(id: String) async {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        
        var item = items[index]
        item.checked.toggle()
        
        do {
            try await firebaseService.updateShoppingItem(id: id, item)
            items[index].checked = item.checked
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteItem(id: String) async -> Bool {
        do {
            try await firebaseService.deleteShoppingItem(id: id)
            await loadItems()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func clearCheckedItems() async {
        let checkedIds = checkedItems.compactMap { $0.id }
        
        for id in checkedIds {
            _ = await deleteItem(id: id)
        }
    }
    
    func addIngredientsFromRecipe(ingredients: [Ingredient]) async {
        for ingredient in ingredients {
            let quantity = "\(ingredient.amount) \(ingredient.unit)"
            _ = await addItem(name: ingredient.name, quantity: quantity, category: nil)
        }
    }
}
