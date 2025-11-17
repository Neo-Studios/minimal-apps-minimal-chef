package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.domain.model.MealKit
import com.neostudios.zest.domain.repository.MealKitRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MealKitViewModel @Inject constructor(
    private val mealKitRepository: MealKitRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(MealKitUiState())
    val uiState: StateFlow<MealKitUiState> = _uiState

    init {
        loadMealKits()
    }

    fun loadMealKits() {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val mealKits = mealKitRepository.getMealKits()
                _uiState.value = _uiState.value.copy(
                    mealKits = mealKits,
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

    fun loadMealKitDetail(id: String) {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val mealKit = mealKitRepository.getMealKit(id)
                _uiState.value = _uiState.value.copy(
                    selectedMealKit = mealKit,
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
}

data class MealKitUiState(
    val mealKits: List<MealKit> = emptyList(),
    val selectedMealKit: MealKit? = null,
    val isLoading: Boolean = false,
    val error: String? = null
)
