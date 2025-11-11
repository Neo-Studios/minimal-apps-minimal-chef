package com.neostudios.zest.domain.model

import com.google.firebase.Timestamp

data class ShoppingListItem(
    val id: String = "",
    val name: String = "",
    val amount: String = "",
    val unit: String = "",
    val category: String = "",
    val checked: Boolean = false,
    val recipeId: String? = null,
    val recipeName: String? = null,
    val createdAt: Timestamp = Timestamp.now()
)

data class ShoppingList(
    val id: String = "",
    val userId: String = "",
    val items: List<ShoppingListItem> = emptyList(),
    val createdAt: Timestamp = Timestamp.now(),
    val updatedAt: Timestamp = Timestamp.now()
)
