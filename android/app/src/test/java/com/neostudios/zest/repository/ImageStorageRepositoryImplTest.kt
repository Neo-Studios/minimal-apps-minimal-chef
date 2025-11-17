package com.neostudios.zest.repository

import android.net.Uri
import com.google.firebase.storage.FirebaseStorage
import com.google.firebase.storage.StorageReference
import com.google.firebase.storage.UploadTask
import com.neostudios.zest.data.repository.ImageStorageRepositoryImpl
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals

@ExperimentalCoroutinesApi
class ImageStorageRepositoryImplTest {

    private lateinit var repository: ImageStorageRepositoryImpl
    private val storage: FirebaseStorage = mockk()
    private val storageReference: StorageReference = mockk()
    private val uploadTask: UploadTask = mockk()
    private val uri: Uri = mockk()

    @Before
    fun setup() {
        coEvery { storage.reference.child(any()) } returns storageReference
        coEvery { storageReference.putFile(uri) } returns uploadTask
        coEvery { uploadTask.isSuccessful } returns true
        coEvery { storageReference.downloadUrl.result } returns uri
        repository = ImageStorageRepositoryImpl(storage)
    }

    @Test
    fun `uploadImage returns download URL on success`() = runTest {
        val downloadUrl = "https://example.com/image.jpg"
        coEvery { storageReference.downloadUrl.await() } returns Uri.parse(downloadUrl)

        val result = repository.uploadImage(uri, "test_path")

        assertEquals(downloadUrl, result)
    }

    @Test(expected = Exception::class)
    fun `uploadImage throws exception on failure`() = runTest {
        coEvery { storageReference.putFile(uri).await() } throws Exception("Upload failed")

        repository.uploadImage(uri, "test_path")
    }
}
