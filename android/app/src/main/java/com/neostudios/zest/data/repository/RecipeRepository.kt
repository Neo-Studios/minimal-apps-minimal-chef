package com.neostudios.zest.data.repository

import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.model.Recipe
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class RecipeRepository @Inject constructor(
    private val firestore: FirebaseFirestore
) {
    private val recipesCollection = firestore.collection("recipes")
    
    suspend fun addRecipe(recipe: Recipe): String {
        val docRef = recipesCollection.add(recipe.toMap()).await()
        return docRef.id
    }
    
    suspend fun getRecipes(userId: String): List<Recipe> {
        val snapshot = recipesCollection
            .whereEqualTo("userId", userId)
            .get()
            .await()
        return snapshot.documents.mapNotNull { doc ->
            doc.toObject(Recipe::class.java)?.copy(id = doc.id)
        }
    }
    
    suspend fun updateRecipe(id: String, data: Map<String, Any>) {
        recipesCollection.document(id).update(data).await()
    }
    
    suspend fun deleteRecipe(id: String) {
        recipesCollection.document(id).delete().await()
    }
}
