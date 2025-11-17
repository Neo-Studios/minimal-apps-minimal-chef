import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseService {
    static let shared = FirebaseService()
    private let db = Firestore.firestore()
    
    private init() {
        // Enable offline persistence
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        db.settings = settings
    }
    
    // MARK: - Authentication
    
    func signInWithGoogle() async throws -> User {
        // TODO: Implement Google Sign-In
        // For now, return mock user
        throw NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Not implemented"])
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
    
    // MARK: - Recipes
    
    func getRecipes(userId: String) async throws -> [Recipe] {
        let snapshot = try await db.collection("recipes")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Recipe.self)
        }
    }
    
    func getRecipe(id: String) async throws -> Recipe? {
        let doc = try await db.collection("recipes").document(id).getDocument()
        return try? doc.data(as: Recipe.self)
    }
    
    func createRecipe(_ recipe: Recipe) async throws -> String {
        let ref = try db.collection("recipes").addDocument(from: recipe)
        return ref.documentID
    }
    
    func updateRecipe(id: String, _ recipe: Recipe) async throws {
        try db.collection("recipes").document(id).setData(from: recipe, merge: true)
    }
    
    func deleteRecipe(id: String) async throws {
        try await db.collection("recipes").document(id).delete()
    }
    
    // MARK: - Cookbooks
    
    func getCookbooks(userId: String) async throws -> [Cookbook] {
        let snapshot = try await db.collection("cookbooks")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: Cookbook.self)
        }
    }
    
    func createCookbook(_ cookbook: Cookbook) async throws -> String {
        let ref = try db.collection("cookbooks").addDocument(from: cookbook)
        return ref.documentID
    }
    
    func updateCookbook(id: String, _ cookbook: Cookbook) async throws {
        try db.collection("cookbooks").document(id).setData(from: cookbook, merge: true)
    }
    
    func deleteCookbook(id: String) async throws {
        try await db.collection("cookbooks").document(id).delete()
    }
    
    // MARK: - Meal Plans
    
    func getMealPlans(userId: String, startDate: String, endDate: String) async throws -> [MealPlan] {
        let snapshot = try await db.collection("mealPlans")
            .whereField("userId", isEqualTo: userId)
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThanOrEqualTo: endDate)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: MealPlan.self)
        }
    }
    
    func addMealToDate(userId: String, date: String, mealType: String, recipeId: String) async throws {
        // Check if meal plan exists
        let snapshot = try await db.collection("mealPlans")
            .whereField("userId", isEqualTo: userId)
            .whereField("date", isEqualTo: date)
            .getDocuments()
        
        if let doc = snapshot.documents.first {
            // Update existing
            var meals = doc.data()["meals"] as? [String: [String]] ?? [:]
            var mealArray = meals[mealType] ?? []
            mealArray.append(recipeId)
            meals[mealType] = mealArray
            
            try await doc.reference.updateData([
                "meals": meals,
                "updatedAt": FieldValue.serverTimestamp()
            ])
        } else {
            // Create new
            try await db.collection("mealPlans").addDocument(data: [
                "userId": userId,
                "date": date,
                "meals": [mealType: [recipeId]],
                "createdAt": FieldValue.serverTimestamp(),
                "updatedAt": FieldValue.serverTimestamp()
            ])
        }
    }
    
    func removeMealFromDate(userId: String, date: String, mealType: String, recipeId: String) async throws {
        let snapshot = try await db.collection("mealPlans")
            .whereField("userId", isEqualTo: userId)
            .whereField("date", isEqualTo: date)
            .getDocuments()
        
        guard let doc = snapshot.documents.first else { return }
        
        var meals = doc.data()["meals"] as? [String: [String]] ?? [:]
        var mealArray = meals[mealType] ?? []
        mealArray.removeAll { $0 == recipeId }
        meals[mealType] = mealArray
        
        try await doc.reference.updateData([
            "meals": meals,
            "updatedAt": FieldValue.serverTimestamp()
        ])
    }
    
    // MARK: - Shopping List
    
    func getShoppingList(userId: String) async throws -> [ShoppingItem] {
        let snapshot = try await db.collection("shoppingLists")
            .document(userId)
            .collection("items")
            .order(by: "createdAt", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: ShoppingItem.self)
        }
    }
    
    func addShoppingItem(userId: String, item: ShoppingItem) async throws {
        try db.collection("shoppingLists")
            .document(userId)
            .collection("items")
            .addDocument(from: item)
    }
    
    func updateShoppingItem(userId: String, itemId: String, checked: Bool) async throws {
        try await db.collection("shoppingLists")
            .document(userId)
            .collection("items")
            .document(itemId)
            .updateData(["checked": checked])
    }
    
    func deleteShoppingItem(userId: String, itemId: String) async throws {
        try await db.collection("shoppingLists")
            .document(userId)
            .collection("items")
            .document(itemId)
            .delete()
    }
    
    // MARK: - Nutrition
    
    func logNutrition(userId: String, entry: NutritionEntry) async throws {
        try db.collection("nutrition").addDocument(from: entry)
    }
    
    func getNutritionEntries(userId: String, startDate: String, endDate: String) async throws -> [NutritionEntry] {
        let snapshot = try await db.collection("nutrition")
            .whereField("userId", isEqualTo: userId)
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThanOrEqualTo: endDate)
            .order(by: "date", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: NutritionEntry.self)
        }
    }

    // MARK: - Meal Kits

    func getMealKits() async throws -> [MealKit] {
        let snapshot = try await db.collection("mealKits").getDocuments()
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: MealKit.self)
        }
    }

    func getMealKit(id: String) async throws -> MealKit? {
        let doc = try await db.collection("mealKits").document(id).getDocument()
        return try? doc.data(as: MealKit.self)
    }

    func getAvailableMealKits(date: String) async throws -> [MealKit] {
        let snapshot = try await db.collection("mealKits")
            .whereField("availableDates", arrayContains: date)
            .getDocuments()
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: MealKit.self)
        }
    }

    // MARK: - Collaborative Meal Plans

    func getCollaborativeMealPlans(userId: String) async throws -> [CollaborativeMealPlan] {
        let snapshot = try await db.collection("collaborativeMealPlans")
            .whereField("members", arrayContains: ["userId": userId]) // Simplified for now
            .getDocuments()
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: CollaborativeMealPlan.self)
        }
    }

    func getCollaborativeMealPlan(id: String) async throws -> CollaborativeMealPlan? {
        let doc = try await db.collection("collaborativeMealPlans").document(id).getDocument()
        return try? doc.data(as: CollaborativeMealPlan.self)
    }

    func createCollaborativeMealPlan(_ plan: CollaborativeMealPlan) async throws -> String {
        let ref = try db.collection("collaborativeMealPlans").addDocument(from: plan)
        return ref.documentID
    }

    func updateCollaborativeMealPlan(id: String, _ plan: CollaborativeMealPlan) async throws {
        try db.collection("collaborativeMealPlans").document(id).setData(from: plan, merge: true)
    }

    func deleteCollaborativeMealPlan(id: String) async throws {
        try await db.collection("collaborativeMealPlans").document(id).delete()
    }

    func addMemberToCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) async throws {
        try await db.collection("collaborativeMealPlans").document(planId).updateData([
            "members": FieldValue.arrayUnion(["userId": member.userId, "role": member.role])
        ])
    }

    func removeMemberFromCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) async throws {
        try await db.collection("collaborativeMealPlans").document(planId).updateData([
            "members": FieldValue.arrayRemove(["userId": member.userId, "role": member.role])
        ])
    }

    func addMealPlanToCollaborativePlan(planId: String, mealPlanId: String) async throws {
        try await db.collection("collaborativeMealPlans").document(planId).updateData([
            "mealPlanIds": FieldValue.arrayUnion(mealPlanId)
        ])
    }

    func removeMealPlanFromCollaborativePlan(planId: String, mealPlanId: String) async throws {
        try await db.collection("collaborativeMealPlans").document(planId).updateData([
            "mealPlanIds": FieldValue.arrayRemove(mealPlanId)
        ])
    }

// MARK: - Models

struct ShoppingItem: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var amount: String?
    var category: String
    var checked: Bool
    var createdAt: Date?
}

struct NutritionEntry: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var date: String
    var recipeId: String?
    var recipeName: String?
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
    var servings: Double
    var createdAt: Date?
}
