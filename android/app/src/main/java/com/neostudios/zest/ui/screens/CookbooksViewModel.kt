package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.domain.model.Cookbook
import com.neostudios.zest.domain.model.Recipe
import com.neostudios.zest.data.repository.CookbookRepository
import com.neostudios.zest.data.repository.RecipeRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class CookbooksViewModel @Inject constructor(
    private val cookbookRepository: CookbookRepository,
    private val recipeRepository: RecipeRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(CookbooksUiState())
    val uiState: StateFlow<CookbooksUiState> = _uiState

    init {
        loadCookbooks()
        loadAllRecipes()
    }

    fun loadCookbooks() {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val cookbooks = cookbookRepository.getCookbooks()
                _uiState.value = _uiState.value.copy(
                    cookbooks = cookbooks,
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

    private fun loadAllRecipes() {
        viewModelScope.launch {
            try {
                val recipes = recipeRepository.getAllRecipes()
                _uiState.value = _uiState.value.copy(allRecipes = recipes)
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun createCookbook(name: String, description: String, isPublic: Boolean) {
        viewModelScope.launch {
            try {
                val newCookbook = Cookbook(
                    name = name,
                    description = description,
                    isPublic = isPublic,
                    recipeIds = emptyList()
                )
                cookbookRepository.createCookbook(newCookbook)
                loadCookbooks()
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun updateCookbook(cookbook: Cookbook) {
        viewModelScope.launch {
            try {
                cookbookRepository.updateCookbook(cookbook)
                loadCookbooks()
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun deleteCookbook(cookbookId: String) {
        viewModelScope.launch {
            try {
                cookbookRepository.deleteCookbook(cookbookId)
                loadCookbooks()
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun addRecipeToCookbook(cookbookId: String, recipeId: String) {
        viewModelScope.launch {
            try {
                val cookbook = _uiState.value.cookbooks.find { it.id == cookbookId }
                if (cookbook != null && !cookbook.recipeIds.contains(recipeId)) {
                    val updatedRecipeIds = cookbook.recipeIds + recipeId
                    cookbookRepository.updateCookbook(cookbook.copy(recipeIds = updatedRecipeIds))
                    loadCookbooks()
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun removeRecipeFromCookbook(cookbookId: String, recipeId: String) {
        viewModelScope.launch {
            try {
                val cookbook = _uiState.value.cookbooks.find { it.id == cookbookId }
                if (cookbook != null && cookbook.recipeIds.contains(recipeId)) {
                    val updatedRecipeIds = cookbook.recipeIds.filter { it != recipeId }
                    cookbookRepository.updateCookbook(cookbook.copy(recipeIds = updatedRecipeIds))
                    loadCookbooks()
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }
}

data class CookbooksUiState(
    val cookbooks: List<Cookbook> = emptyList(),
    val allRecipes: List<Recipe> = emptyList(),
    val isLoading: Boolean = false,
    val error: String? = null
)
