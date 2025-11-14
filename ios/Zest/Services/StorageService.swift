import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    private let storage = Storage.storage()
    
    private init() {}
    
    func uploadRecipeImage(imageData: Data, recipeId: String) async throws -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let fileName = "recipe_\(timestamp).jpg"
        let storageRef = storage.reference().child("recipes/\(recipeId)/\(fileName)")
        
        _ = try await storageRef.putDataAsync(imageData)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func uploadUserProfileImage(imageData: Data, userId: String) async throws -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let fileName = "profile_\(timestamp).jpg"
        let storageRef = storage.reference().child("users/\(userId)/profile/\(fileName)")
        
        _ = try await storageRef.putDataAsync(imageData)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func uploadCookbookCover(imageData: Data, cookbookId: String) async throws -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let fileName = "cover_\(timestamp).jpg"
        let storageRef = storage.reference().child("cookbooks/\(cookbookId)/\(fileName)")
        
        _ = try await storageRef.putDataAsync(imageData)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func deleteImage(imageUrl: String) async throws {
        let storageRef = storage.reference(forURL: imageUrl)
        try await storageRef.delete()
    }
}
