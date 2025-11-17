package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.domain.model.MealPlan
import com.neostudios.zest.domain.model.Recipe
import com.neostudios.zest.domain.repository.MealPlanRepository
import com.neostudios.zest.domain.repository.RecipeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import java.time.LocalDate
import javax.inject.Inject

@HiltViewModel
class MealPlanViewModel @Inject constructor(
    private val mealPlanRepository: MealPlanRepository,
    private val recipeRepository: RecipeRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(MealPlanUiState())
    val uiState: StateFlow<MealPlanUiState> = _uiState

    init {
        loadMealPlans(LocalDate.now())
        loadRecipes()
    }

    fun loadMealPlans(selectedDate: LocalDate) {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val mealPlans = mealPlanRepository.getMealPlansForWeek(selectedDate)
                _uiState.value = _uiState.value.copy(
                    mealPlans = mealPlans,
                    selectedDate = selectedDate,
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

    private fun loadRecipes() {
        viewModelScope.launch {
            try {
                val recipes = recipeRepository.getAllRecipes()
                _uiState.value = _uiState.value.copy(allRecipes = recipes)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun addRecipeToMealPlan(date: LocalDate, mealType: String, recipeId: String) {
        viewModelScope.launch {
            try {
                mealPlanRepository.addRecipeToMealPlan(date, mealType, recipeId)
                loadMealPlans(_uiState.value.selectedDate) // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun removeRecipeFromMealPlan(date: LocalDate, mealType: String, recipeId: String) {
        viewModelScope.launch {
            try {
                mealPlanRepository.removeRecipeFromMealPlan(date, mealType, recipeId)
                loadMealPlans(_uiState.value.selectedDate) // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun changeSelectedDate(days: Long) {
        val newDate = _uiState.value.selectedDate.plusDays(days)
        loadMealPlans(newDate)
    }
}

data class MealPlanUiState(
    val mealPlans: Map<LocalDate, MealPlan> = emptyMap(),
    val allRecipes: List<Recipe> = emptyList(),
    val selectedDate: LocalDate = LocalDate.now(),
    val isLoading: Boolean = false,
    val error: String? = null
)
