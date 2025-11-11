package com.neostudios.zest.domain.usecase

import com.neostudios.zest.domain.model.Recipe

data class SearchFilters(
    val query: String? = null,
    val cuisineType: String? = null,
    val mealType: String? = null,
    val difficulty: String? = null,
    val dietaryRestrictions: List<String> = emptyList(),
    val maxPrepTime: Int? = null,
    val maxCookTime: Int? = null,
    val minRating: Float? = null
)

object SearchRecipes {
    fun search(recipes: List<Recipe>, filters: SearchFilters): List<Recipe> {
        return recipes.filter { recipe ->
            // Query filter
            if (filters.query != null) {
                val query = filters.query.lowercase()
                val matchesName = recipe.name.lowercase().contains(query)
                val matchesIngredients = recipe.ingredients.any { 
                    it.name.lowercase().contains(query) 
                }
                if (!matchesName && !matchesIngredients) return@filter false
            }
            
            // Cuisine filter
            if (filters.cuisineType != null && recipe.cuisineType != filters.cuisineType) {
                return@filter false
            }
            
            // Meal type filter
            if (filters.mealType != null && recipe.mealType != filters.mealType) {
                return@filter false
            }
            
            // Difficulty filter
            if (filters.difficulty != null && recipe.difficulty != filters.difficulty) {
                return@filter false
            }
            
            // Dietary restrictions filter
            if (filters.dietaryRestrictions.isNotEmpty()) {
                val hasAll = filters.dietaryRestrictions.all { restriction ->
                    recipe.dietaryRestrictions?.contains(restriction) == true
                }
                if (!hasAll) return@filter false
            }
            
            // Time filters
            if (filters.maxPrepTime != null && recipe.prepTime != null && recipe.prepTime > filters.maxPrepTime) {
                return@filter false
            }
            
            if (filters.maxCookTime != null && recipe.cookTime != null && recipe.cookTime > filters.maxCookTime) {
                return@filter false
            }
            
            // Rating filter
            if (filters.minRating != null && recipe.rating != null && recipe.rating < filters.minRating) {
                return@filter false
            }
            
            true
        }
    }
}
