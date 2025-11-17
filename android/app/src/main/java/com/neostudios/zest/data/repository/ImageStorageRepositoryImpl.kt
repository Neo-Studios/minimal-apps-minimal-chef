package com.neostudios.zest.data.repository

import android.net.Uri
import com.google.firebase.storage.FirebaseStorage
import com.neostudios.zest.domain.repository.ImageStorageRepository
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ImageStorageRepositoryImpl @Inject constructor(
    private val storage: FirebaseStorage
) : ImageStorageRepository {

    override suspend fun uploadImage(imageUri: Uri, path: String): String {
        val ref = storage.reference.child(path)
        ref.putFile(imageUri).await()
        return ref.downloadUrl.await().toString()
    }

    override suspend fun deleteImage(imageUrl: String) {
        val ref = storage.getReferenceFromUrl(imageUrl)
        ref.delete().await()
    }
}
