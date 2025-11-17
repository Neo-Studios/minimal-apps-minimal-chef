import Foundation
import FirebaseFirestore

struct ShoppingItem: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var name: String
    var quantity: String
    var category: String?
    var checked: Bool
    var createdAt: Date?
}
