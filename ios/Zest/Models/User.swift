import Foundation

struct User: Codable {
    var uid: String
    var email: String
    var displayName: String
    var photoURL: String?
}
