package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.model.Cookbook
import kotlinx.coroutines.tasks.await

class CookbookRepository {
    private val firestore = FirebaseFirestore.getInstance()
    private val cookbooksCollection = firestore.collection("cookbooks")
    
    suspend fun getCookbooks(userId: String): List<Cookbook> {
        return try {
            val snapshot = cookbooksCollection
                .whereEqualTo("userId", userId)
                .get()
                .await()
            
            snapshot.documents.mapNotNull { doc ->
                Cookbook.fromMap(doc.data ?: return@mapNotNull null, doc.id)
            }
        } catch (e: Exception) {
            emptyList()
        }
    }
    
    suspend fun addCookbook(cookbook: Cookbook): String? {
        return try {
            val docRef = cookbooksCollection.add(cookbook.toMap()).await()
            docRef.id
        } catch (e: Exception) {
            null
        }
    }
    
    suspend fun updateCookbook(cookbook: Cookbook) {
        try {
            cookbook.id?.let { id ->
                cookbooksCollection.document(id).set(cookbook.toMap()).await()
            }
        } catch (e: Exception) {
            // Handle error
        }
    }
    
    suspend fun deleteCookbook(cookbookId: String) {
        try {
            cookbooksCollection.document(cookbookId).delete().await()
        } catch (e: Exception) {
            // Handle error
        }
    }
    
    suspend fun addRecipeToCookbook(cookbookId: String, recipeId: String) {
        try {
            val doc = cookbooksCollection.document(cookbookId).get().await()
            val cookbook = Cookbook.fromMap(doc.data ?: return, doc.id)
            val updatedRecipeIds = cookbook.recipeIds + recipeId
            cookbooksCollection.document(cookbookId)
                .update("recipeIds", updatedRecipeIds)
                .await()
        } catch (e: Exception) {
            // Handle error
        }
    }
}
