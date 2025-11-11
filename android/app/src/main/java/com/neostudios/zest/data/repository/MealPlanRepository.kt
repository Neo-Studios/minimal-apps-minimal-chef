package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FirebaseFirestore
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class MealPlanRepository @Inject constructor(
    private val firestore: FirebaseFirestore
) {
    
    suspend fun saveMealPlan(userId: String, date: String, meals: List<String>) {
        firestore.collection("mealPlans")
            .document(userId)
            .collection("plans")
            .document(date)
            .set(mapOf("meals" to meals, "date" to date))
            .await()
    }
    
    fun observeMealPlans(userId: String): Flow<Map<String, List<String>>> = callbackFlow {
        val listener = firestore.collection("mealPlans")
            .document(userId)
            .collection("plans")
            .addSnapshotListener { snapshot, _ ->
                val plans = mutableMapOf<String, List<String>>()
                snapshot?.documents?.forEach { doc ->
                    val meals = doc.get("meals") as? List<String> ?: emptyList()
                    plans[doc.id] = meals
                }
                trySend(plans)
            }
        awaitClose { listener.remove() }
    }
}
