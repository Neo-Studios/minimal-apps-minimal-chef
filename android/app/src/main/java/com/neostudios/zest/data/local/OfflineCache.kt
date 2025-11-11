package com.neostudios.zest.data.local

import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.FirebaseFirestoreSettings
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class OfflineCache @Inject constructor(
    private val firestore: FirebaseFirestore
) {
    fun enableOfflinePersistence() {
        val settings = FirebaseFirestoreSettings.Builder()
            .setPersistenceEnabled(true)
            .setCacheSizeBytes(FirebaseFirestoreSettings.CACHE_SIZE_UNLIMITED)
            .build()
        firestore.firestoreSettings = settings
    }
}
