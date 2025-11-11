import Foundation
import FirebaseFirestore

class OfflineCache {
    static func enableOfflinePersistence() {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        Firestore.firestore().settings = settings
    }
}
