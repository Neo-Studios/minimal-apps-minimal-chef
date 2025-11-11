package com.neostudios.zest.domain.model

import com.google.firebase.Timestamp

data class Ingredient(
    val name: String = "",
    val amount: String = "",
    val unit: String = ""
)

data class Recipe(
    val id: String = "",
    val name: String = "",
    val userId: String = "",
    val ingredients: List<Ingredient> = emptyList(),
    val instructions: List<String> = emptyList(),
    val prepTime: Int = 0,
    val cookTime: Int = 0,
    val servings: Int = 0,
    val cuisineType: String = "",
    val mealType: String = "",
    val imageUrl: String? = null,
    val createdAt: Timestamp = Timestamp.now(),
    val updatedAt: Timestamp = Timestamp.now()
) {
    fun toMap(): Map<String, Any?> = mapOf(
        "name" to name,
        "userId" to userId,
        "ingredients" to ingredients.map { mapOf("name" to it.name, "amount" to it.amount, "unit" to it.unit) },
        "instructions" to instructions,
        "prepTime" to prepTime,
        "cookTime" to cookTime,
        "servings" to servings,
        "cuisineType" to cuisineType,
        "mealType" to mealType,
        "imageUrl" to imageUrl,
        "createdAt" to createdAt,
        "updatedAt" to updatedAt
    )
}
