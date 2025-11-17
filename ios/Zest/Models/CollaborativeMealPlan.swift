import Foundation
import FirebaseFirestoreSwift

struct CollaborativeMealPlan: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var ownerId: String
    var members: [CollaborativeMealPlanMember]
    var mealPlanIds: [String] // References to individual meal plans
    var createdAt: Date?
    var updatedAt: Date?
}

struct CollaborativeMealPlanMember: Codable, Hashable {
    var userId: String
    var role: String // "owner", "editor", "viewer"
}
