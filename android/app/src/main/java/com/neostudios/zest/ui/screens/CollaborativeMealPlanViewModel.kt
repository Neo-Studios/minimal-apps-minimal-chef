package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.firebase.auth.FirebaseAuth
import com.neostudios.zest.domain.model.CollaborativeMealPlan
import com.neostudios.zest.domain.model.CollaborativeMealPlanMember
import com.neostudios.zest.domain.repository.CollaborativeMealPlanRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CollaborativeMealPlanViewModel @Inject constructor(
    private val collaborativeMealPlanRepository: CollaborativeMealPlanRepository,
    private val auth: FirebaseAuth
) : ViewModel() {

    private val _uiState = MutableStateFlow(CollaborativeMealPlanUiState())
    val uiState: StateFlow<CollaborativeMealPlanUiState> = _uiState

    init {
        loadCollaborativeMealPlans()
    }

    fun loadCollaborativeMealPlans() {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            auth.currentUser?.uid?.let { userId ->
                try {
                    val plans = collaborativeMealPlanRepository.getCollaborativeMealPlans(userId)
                    _uiState.value = _uiState.value.copy(
                        collaborativeMealPlans = plans,
                        isLoading = false
                    )
                } catch (e: Exception) {
                    _uiState.value = _uiState.value.copy(
                        error = e.localizedMessage,
                        isLoading = false
                    )
                }
            } ?: run {
                _uiState.value = _uiState.value.copy(
                    error = "User not authenticated",
                    isLoading = false
                )
            }
        }
    }

    fun loadCollaborativeMealPlanDetail(id: String) {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val plan = collaborativeMealPlanRepository.getCollaborativeMealPlan(id)
                _uiState.value = _uiState.value.copy(
                    selectedCollaborativeMealPlan = plan,
                    isLoading = false
                )
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    error = e.localizedMessage,
                    isLoading = false
                )
            }
        }
    }

    fun createCollaborativeMealPlan(name: String) {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            auth.currentUser?.uid?.let { userId ->
                try {
                    collaborativeMealPlanRepository.createCollaborativeMealPlan(name, userId)
                    loadCollaborativeMealPlans()
                } catch (e: Exception) {
                    _uiState.value = _uiState.value.copy(error = e.localizedMessage)
                } finally {
                    _uiState.value = _uiState.value.copy(isLoading = false)
                }
            }
        }
    }

    fun addMemberToCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        viewModelScope.launch {
            try {
                collaborativeMealPlanRepository.addMemberToCollaborativeMealPlan(planId, member)
                loadCollaborativeMealPlanDetail(planId)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun removeMemberFromCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember) {
        viewModelScope.launch {
            try {
                collaborativeMealPlanRepository.removeMemberFromCollaborativeMealPlan(planId, member)
                loadCollaborativeMealPlanDetail(planId)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun addMealPlanToCollaborativePlan(planId: String, mealPlanId: String) {
        viewModelScope.launch {
            try {
                collaborativeMealPlanRepository.addMealPlanToCollaborativePlan(planId, mealPlanId)
                loadCollaborativeMealPlanDetail(planId)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun removeMealPlanFromCollaborativePlan(planId: String, mealPlanId: String) {
        viewModelScope.launch {
            try {
                collaborativeMealPlanRepository.removeMealPlanFromCollaborativePlan(planId, mealPlanId)
                loadCollaborativeMealPlanDetail(planId)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }
}

data class CollaborativeMealPlanUiState(
    val collaborativeMealPlans: List<CollaborativeMealPlan> = emptyList(),
    val selectedCollaborativeMealPlan: CollaborativeMealPlan? = null,
    val isLoading: Boolean = false,
    val error: String? = null
)
