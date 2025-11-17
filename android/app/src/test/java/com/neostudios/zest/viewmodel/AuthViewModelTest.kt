package com.neostudios.zest.viewmodel

import com.google.firebase.auth.FirebaseUser
import com.neostudios.zest.domain.repository.AuthRepository
import com.neostudios.zest.ui.screens.AuthViewModel
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.test.setMain
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertNotNull
import kotlin.test.assertNull

@ExperimentalCoroutinesApi
class AuthViewModelTest {

    private lateinit var viewModel: AuthViewModel
    private val authRepository: AuthRepository = mockk()
    private val testDispatcher = UnconfinedTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        coEvery { authRepository.currentUser } returns flowOf(null)
        viewModel = AuthViewModel(authRepository)
    }

    @Test
    fun `signInWithGoogle updates currentUser on success`() = runTest {
        val mockUser: FirebaseUser = mockk()
        coEvery { authRepository.signInWithGoogle(any()) } returns mockUser
        coEvery { authRepository.currentUser } returns flowOf(mockUser)

        viewModel.signInWithGoogle("test_token")

        val currentUser = viewModel.currentUser.first()
        assertNotNull(currentUser)
    }

    @Test
    fun `signInWithGoogle updates error on failure`() = runTest {
        val errorMessage = "Sign-in failed"
        coEvery { authRepository.signInWithGoogle(any()) } throws Exception(errorMessage)

        viewModel.signInWithGoogle("test_token")

        val error = viewModel.error.first()
        assertEquals(errorMessage, error)
    }

    @Test
    fun `signOut updates currentUser to null`() = runTest {
        coEvery { authRepository.signOut() } returns Unit
        coEvery { authRepository.currentUser } returns flowOf(null)

        viewModel.signOut()

        val currentUser = viewModel.currentUser.first()
        assertNull(currentUser)
    }

    @Test
    fun `clearError clears the error message`() = runTest {
        val errorMessage = "An error occurred"
        coEvery { authRepository.signInWithGoogle(any()) } throws Exception(errorMessage)
        viewModel.signInWithGoogle("test_token")

        var error = viewModel.error.first()
        assertEquals(errorMessage, error)

        viewModel.clearError()
        error = viewModel.error.first()
        assertNull(error)
    }
}
