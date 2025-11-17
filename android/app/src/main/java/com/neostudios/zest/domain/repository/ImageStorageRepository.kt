package com.neostudios.zest.domain.repository

import android.net.Uri

interface ImageStorageRepository {
    suspend fun uploadImage(imageUri: Uri, path: String): String
    suspend fun deleteImage(imageUrl: String)
}
