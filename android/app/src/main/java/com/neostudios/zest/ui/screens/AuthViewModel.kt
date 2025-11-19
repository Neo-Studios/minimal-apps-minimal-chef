package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.firebase.auth.FirebaseUser
import com.neostudios.zest.domain.repository.AuthRepository
import com.neostudios.zest.domain.repository.UserProfileRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val authRepository: AuthRepository,
    private val userProfileRepository: UserProfileRepository
) : ViewModel() {

    private val _currentUser = MutableStateFlow<FirebaseUser?>(null)
    val currentUser: StateFlow<FirebaseUser?> = _currentUser

    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading

    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error

    private val _showOnboarding = MutableStateFlow(false)
    val showOnboarding: StateFlow<Boolean> = _showOnboarding

    init {
        viewModelScope.launch {
            authRepository.currentUser.collect { user ->
                _currentUser.value = user
                if (user != null) {
                    _showOnboarding.value = !userProfileRepository.getOnboardingStatus(user.uid)
                } else {
                    _showOnboarding.value = false
                }
            }
        }
    }

    fun signInWithGoogle(idToken: String) {
        _isLoading.value = true
        _error.value = null
        viewModelScope.launch {
            try {
                authRepository.signInWithGoogle(idToken)
            } catch (e: Exception) {
                _error.value = e.localizedMessage
            } finally {
                _isLoading.value = false
            }
        }
    }

    fun signOut() {
        _isLoading.value = true
        _error.value = null
        viewModelScope.launch {
            try {
                authRepository.signOut()
            } catch (e: Exception) {
                _error.value = e.localizedMessage
            } finally {
                _isLoading.value = false
            }
        }
    }

    fun completeOnboarding(userId: String) {
        viewModelScope.launch {
            userProfileRepository.setOnboardingStatus(userId, true)
            _showOnboarding.value = false
        }
    }

    fun clearError() {
        _error.value = null
    }
}
