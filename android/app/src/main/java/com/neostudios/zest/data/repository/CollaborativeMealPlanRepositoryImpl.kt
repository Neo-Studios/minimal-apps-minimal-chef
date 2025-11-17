package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.model.CollaborativeMealPlan
import com.neostudios.zest.domain.model.CollaborativeMealPlanMember
import com.neostudios.zest.domain.repository.CollaborativeMealPlanRepository
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class CollaborativeMealPlanRepositoryImpl @Inject constructor(
    private val firestore: FirebaseFirestore
) : CollaborativeMealPlanRepository {

    private val collaborativeMealPlansCollection = firestore.collection("collaborativeMealPlans")

    override suspend fun getCollaborativeMealPlans(userId: String): List<CollaborativeMealPlan> {
        val snapshot = collaborativeMealPlansCollection
            .whereArrayContains("members", CollaborativeMealPlanMember(userId = userId)) // Simplified for now
            .get()
            .await()
        return snapshot.documents.mapNotNull { doc ->
            doc.toObject(CollaborativeMealPlan::class.java)?.copy(id = doc.id)
        }
    }

    override suspend fun getCollaborativeMealPlan(id: String): CollaborativeMealPlan? {
        val snapshot = collaborativeMealPlansCollection.document(id).get().await()
        return snapshot.toObject(CollaborativeMealPlan::class.java)?.copy(id = snapshot.id)
    }

    override suspend fun createCollaborativeMealPlan(name: String, ownerId: String): String {
        val newPlan = CollaborativeMealPlan(
            name = name,
            ownerId = ownerId,
            members = listOf(CollaborativeMealPlanMember(userId = ownerId, role = "owner")),
            mealPlanIds = emptyList()
        )
        val docRef = collaborativeMealPlansCollection.add(newPlan).await()
        return docRef.id
    }

    override suspend fun updateCollaborativeMealPlan(id: String, collaborativeMealPlan: CollaborativeMealPlan) {
        collaborativeMealPlansCollection.document(id).set(collaborativeMealPlan).await()
    }

    override suspend fun deleteCollaborativeMealPlan(id: String) {
        collaborativeMealPlansCollection.document(id).delete().await()
    }

    override suspend fun addMemberToCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        collaborativeMealPlansCollection.document(planId).update("members", FieldValue.arrayUnion(member)).await()
    }

    override suspend fun removeMemberFromCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        collaborativeMealPlansCollection.document(planId).update("members", FieldValue.arrayRemove(member)).await()
    }

    override suspend fun addMealPlanToCollaborativePlan(planId: String, mealPlanId: String) {
        collaborativeMealPlansCollection.document(planId).update("mealPlanIds", FieldValue.arrayUnion(mealPlanId)).await()
    }

    override suspend fun removeMealPlanFromCollaborativePlan(planId: String, mealPlanId: String) {
        collaborativeMealPlansCollection.document(planId).update("mealPlanIds", FieldValue.arrayRemove(mealPlanId)).await()
    }
}
