package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.firebase.auth.FirebaseAuth
import com.neostudios.zest.data.repository.RecipeRepository
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
    
    init {
        loadRecipes()
    }
    
    fun loadRecipes() {
        viewModelScope.launch {
            auth.currentUser?.uid?.let { userId ->
                _recipes.value = repository.getRecipes(userId)
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
}
