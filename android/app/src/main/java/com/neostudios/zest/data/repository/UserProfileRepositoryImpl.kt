package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.repository.UserProfileRepository
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserProfileRepositoryImpl @Inject constructor(
    private val firestore: FirebaseFirestore
) : UserProfileRepository {

    override suspend fun getOnboardingStatus(userId: String): Boolean {
        val userDocRef = firestore.collection("users").document(userId)
        val docSnap = userDocRef.get().await()

        return if (docSnap.exists()) {
            docSnap.getBoolean("hasCompletedOnboarding") ?: false
        } else {
            // If user profile doesn't exist, create a basic one with onboarding not completed
            userDocRef.set(mapOf("hasCompletedOnboarding" to false)).await()
            false
        }
    }

    override suspend fun setOnboardingStatus(userId: String, status: Boolean) {
        val userDocRef = firestore.collection("users").document(userId)
        userDocRef.update("hasCompletedOnboarding", status).await()
    }
}
