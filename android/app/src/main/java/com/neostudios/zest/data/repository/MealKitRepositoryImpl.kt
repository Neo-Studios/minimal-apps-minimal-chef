package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.model.MealKit
import com.neostudios.zest.domain.repository.MealKitRepository
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class MealKitRepositoryImpl @Inject constructor(
    private val firestore: FirebaseFirestore
) : MealKitRepository {

    private val mealKitsCollection = firestore.collection("mealKits")

    override suspend fun getMealKits(): List<MealKit> {
        val snapshot = mealKitsCollection.get().await()
        return snapshot.documents.mapNotNull { doc ->
            doc.toObject(MealKit::class.java)?.copy(id = doc.id)
        }
    }

    override suspend fun getMealKit(id: String): MealKit? {
        val snapshot = mealKitsCollection.document(id).get().await()
        return snapshot.toObject(MealKit::class.java)?.copy(id = snapshot.id)
    }

    override suspend fun getAvailableMealKits(date: String): List<MealKit> {
        val snapshot = mealKitsCollection
            .whereArrayContains("availableDates", date)
            .get()
            .await()
        return snapshot.documents.mapNotNull { doc ->
            doc.toObject(MealKit::class.java)?.copy(id = doc.id)
        }
    }
}
