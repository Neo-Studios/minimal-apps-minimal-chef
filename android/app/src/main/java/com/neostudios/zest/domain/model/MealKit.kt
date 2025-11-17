package com.neostudios.zest.domain.model

import com.google.firebase.firestore.DocumentId

data class MealKit(
    @DocumentId val id: String = "",
    val name: String = "",
    val description: String = "",
    val imageUrl: String = "",
    val price: Double = 0.0,
    val recipes: List<MealKitRecipe> = emptyList(),
    val availableDates: List<String> = emptyList() // YYYY-MM-DD
)

data class MealKitRecipe(
    val recipeId: String = "",
    val servings: Int = 0
)
