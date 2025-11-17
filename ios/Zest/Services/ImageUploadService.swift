import Foundation
import FirebaseStorage
import UIKit

class ImageUploadService {
    static let shared = ImageUploadService()
    private let storage = Storage.storage()
    
    private init() {}
    
    func uploadRecipeImage(_ image: UIImage, recipeId: String) async throws -> String {
        // Compress image
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw ImageUploadError.compressionFailed
        }
        
        // Create storage reference
        let storageRef = storage.reference()
        let imageRef = storageRef.child("recipes/\(recipeId)/image.jpg")
        
        // Upload metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload image
        let _ = try await imageRef.putDataAsync(imageData, metadata: metadata)
        
        // Get download URL
        let downloadURL = try await imageRef.downloadURL()
        return downloadURL.absoluteString
    }
    
    func deleteRecipeImage(recipeId: String) async throws {
        let storageRef = storage.reference()
        let imageRef = storageRef.child("recipes/\(recipeId)/image.jpg")
        try await imageRef.delete()
    }
    
    func uploadUserProfileImage(_ image: UIImage, userId: String) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw ImageUploadError.compressionFailed
        }
        
        let storageRef = storage.reference()
        let imageRef = storageRef.child("users/\(userId)/profile.jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let _ = try await imageRef.putDataAsync(imageData, metadata: metadata)
        let downloadURL = try await imageRef.downloadURL()
        return downloadURL.absoluteString
    }
}

enum ImageUploadError: LocalizedError {
    case compressionFailed
    case uploadFailed
    
    var errorDescription: String? {
        switch self {
        case .compressionFailed:
            return "Failed to compress image"
        case .uploadFailed:
            return "Failed to upload image"
        }
    }
}
