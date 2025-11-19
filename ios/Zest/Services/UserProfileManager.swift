import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserProfileManager: ObservableObject {
    private let db = Firestore.firestore()

    func getOnboardingStatus(userId: String, completion: @escaping (Bool) -> Void) {
        let docRef = db.collection("users").document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let hasCompletedOnboarding = document.data()?["hasCompletedOnboarding"] as? Bool ?? false
                completion(hasCompletedOnboarding)
            } else {
                // If user profile doesn't exist, create a basic one with onboarding not completed
                docRef.setData(["hasCompletedOnboarding": false], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    }
                    completion(false)
                }
            }
        }
    }

    func setOnboardingStatus(userId: String, status: Bool) {
        let docRef = db.collection("users").document(userId)
        docRef.updateData(["hasCompletedOnboarding": status]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
        }
    }
}
