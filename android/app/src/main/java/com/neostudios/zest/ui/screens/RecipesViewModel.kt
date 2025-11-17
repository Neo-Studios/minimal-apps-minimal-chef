package com.neostudios.zest.ui.screens

import android.net.Uri
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.firebase.auth.FirebaseAuth
import com.neostudios.zest.data.repository.RecipeRepository
import com.neostudios.zest.domain.model.Ingredient
import com.neostudios.zest.domain.model.Recipe
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class RecipesViewModel @Inject constructor(
    private val repository: RecipeRepository,
    private val auth: FirebaseAuth
) : ViewModel() {
    
    private val _recipes = MutableStateFlow<List<Recipe>>(emptyList())
    val recipes: StateFlow<List<Recipe>> = _recipes
    
    private val _searchQuery = MutableStateFlow("")
    val searchQuery: StateFlow<String> = _searchQuery

    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading

    private val _error = MutableStateFlow<String?>(null)
    val error: StateFlow<String?> = _error
    
    init {
        loadRecipes()
    }
    
    fun loadRecipes() {
        _isLoading.value = true
        viewModelScope.launch {
            auth.currentUser?.uid?.let { userId ->
                try {
                    _recipes.value = repository.getRecipes(userId)
                } catch (e: Exception) {
                    _error.value = e.localizedMessage
                } finally {
                    _isLoading.value = false
                }
            }
        }
    }
    
    fun updateSearch(query: String) {
        _searchQuery.value = query
    }
    
    fun getFilteredRecipes(): List<Recipe> {
        return if (_searchQuery.value.isEmpty()) {
            _recipes.value
        } else {
            _recipes.value.filter { 
                it.name.contains(_searchQuery.value, ignoreCase = true)
            }
        }
    }

    fun getRecipeById(recipeId: String): Recipe? {
        return _recipes.value.find { it.id == recipeId }
    }

    fun addRecipe(
        name: String,
        ingredients: List<Ingredient>,
        instructions: List<String>,
        prepTime: Int,
        cookTime: Int,
        servings: Int,
        imageUri: Uri?
    ) {
        _isLoading.value = true
        _error.value = null
        viewModelScope.launch {
            auth.currentUser?.uid?.let { userId ->
                try {
                    val newRecipe = Recipe(
                        userId = userId,
                        name = name,
                        ingredients = ingredients,
                        instructions = instructions,
                        prepTime = prepTime,
                        cookTime = cookTime,
                        servings = servings
                    )
                    repository.addRecipe(newRecipe, imageUri)
                    loadRecipes() // Reload recipes after adding
                } catch (e: Exception) {
                    _error.value = e.localizedMessage
                } finally {
                    _isLoading.value = false
                }
            }
        }
    }
}
