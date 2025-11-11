import Foundation
import FirebaseFirestore

class MealPlanService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var mealPlans: [String: [String]] = [:]
    private var listener: ListenerRegistration?
    
    func saveMealPlan(userId: String, date: String, meals: [String]) async throws {
        try await db.collection("mealPlans")
            .document(userId)
            .collection("plans")
            .document(date)
            .setData(["meals": meals, "date": date])
    }
    
    func observeMealPlans(userId: String) {
        listener = db.collection("mealPlans")
            .document(userId)
            .collection("plans")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else { return }
                var plans: [String: [String]] = [:]
                for doc in documents {
                    if let meals = doc.data()["meals"] as? [String] {
                        plans[doc.documentID] = meals
                    }
                }
                self?.mealPlans = plans
            }
    }
    
    deinit {
        listener?.remove()
    }
}
