package com.neostudios.zest.data.repository

import android.net.Uri
import com.google.firebase.firestore.FirebaseFirestore
import com.neostudios.zest.domain.model.Recipe
import com.neostudios.zest.domain.repository.ImageStorageRepository
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class RecipeRepository @Inject constructor(
    private val firestore: FirebaseFirestore,
    private val imageStorageRepository: ImageStorageRepository
) {
    private val recipesCollection = firestore.collection("recipes")
    
    suspend fun addRecipe(recipe: Recipe, imageUri: Uri?): String {
        var imageUrl: String? = null
        if (imageUri != null) {
            imageUrl = imageStorageRepository.uploadImage(imageUri, "recipe_images/${System.currentTimeMillis()}.jpg")
        }
        val recipeWithImage = recipe.copy(imageUrl = imageUrl)
        val docRef = recipesCollection.add(recipeWithImage.toMap()).await()
        return docRef.id
    }
    
    suspend fun getRecipe(id: String): Recipe? {
        val snapshot = recipesCollection.document(id).get().await()
        return snapshot.toObject(Recipe::class.java)?.copy(id = snapshot.id)
    }

    suspend fun getAllRecipes(): List<Recipe> {
        val snapshot = recipesCollection.get().await()
        return snapshot.documents.mapNotNull { doc ->
            doc.toObject(Recipe::class.java)?.copy(id = doc.id)
        }
    }
    
    suspend fun updateRecipe(id: String, recipe: Recipe, imageUri: Uri?) {
        var imageUrl: String? = recipe.imageUrl
        if (imageUri != null) {
            // Delete old image if it exists
            if (!recipe.imageUrl.isNullOrEmpty()) {
                imageStorageRepository.deleteImage(recipe.imageUrl)
            }
            imageUrl = imageStorageRepository.uploadImage(imageUri, "recipe_images/${System.currentTimeMillis()}.jpg")
        } else if (recipe.imageUrl.isNullOrEmpty() && !recipe.imageUrl.isNullOrEmpty()) {
            // If image was removed
            imageStorageRepository.deleteImage(recipe.imageUrl)
            imageUrl = null
        }
        val updatedRecipe = recipe.copy(imageUrl = imageUrl)
        recipesCollection.document(id).set(updatedRecipe.toMap()).await()
    }
    
    suspend fun deleteRecipe(id: String, imageUrl: String?) {
        if (!imageUrl.isNullOrEmpty()) {
            imageStorageRepository.deleteImage(imageUrl)
        }
        recipesCollection.document(id).delete().await()
    }
}
