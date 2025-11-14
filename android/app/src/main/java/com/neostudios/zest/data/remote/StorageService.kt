package com.neostudios.zest.data.remote

import android.net.Uri
import com.google.firebase.storage.FirebaseStorage
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class StorageService @Inject constructor(
    private val storage: FirebaseStorage
) {
    
    suspend fun uploadRecipeImage(uri: Uri, recipeId: String): String {
        val timestamp = System.currentTimeMillis()
        val fileName = "recipe_${timestamp}.jpg"
        val storageRef = storage.reference.child("recipes/$recipeId/$fileName")
        
        storageRef.putFile(uri).await()
        return storageRef.downloadUrl.await().toString()
    }
    
    suspend fun uploadUserProfileImage(uri: Uri, userId: String): String {
        val timestamp = System.currentTimeMillis()
        val fileName = "profile_${timestamp}.jpg"
        val storageRef = storage.reference.child("users/$userId/profile/$fileName")
        
        storageRef.putFile(uri).await()
        return storageRef.downloadUrl.await().toString()
    }
    
    suspend fun uploadCookbookCover(uri: Uri, cookbookId: String): String {
        val timestamp = System.currentTimeMillis()
        val fileName = "cover_${timestamp}.jpg"
        val storageRef = storage.reference.child("cookbooks/$cookbookId/$fileName")
        
        storageRef.putFile(uri).await()
        return storageRef.downloadUrl.await().toString()
    }
    
    suspend fun deleteImage(imageUrl: String) {
        try {
            val storageRef = storage.getReferenceFromUrl(imageUrl)
            storageRef.delete().await()
        } catch (e: Exception) {
            // Handle error silently
        }
    }
}
