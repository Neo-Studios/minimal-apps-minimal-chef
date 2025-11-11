package com.neostudios.zest.domain.model

data class MealPlanEntry(
    val recipeId: String = "",
    val recipeName: String = "",
    val mealType: String = ""
)

data class MealPlan(
    val date: String = "",
    val meals: List<MealPlanEntry> = emptyList()
)
