package com.neostudios.zest.domain.usecase

import com.neostudios.zest.domain.model.Ingredient
import com.neostudios.zest.domain.model.Recipe
import javax.inject.Inject

class GenerateShoppingListUseCase @Inject constructor() {
    
    operator fun invoke(recipes: List<Recipe>): List<Ingredient> {
        val ingredientMap = mutableMapOf<String, Ingredient>()
        
        recipes.forEach { recipe ->
            recipe.ingredients.forEach { ing ->
                val key = ing.name.lowercase()
                if (ingredientMap.containsKey(key)) {
                    val existing = ingredientMap[key]!!
                    ingredientMap[key] = existing.copy(
                        amount = "${existing.amount} + ${ing.amount}"
                    )
                } else {
                    ingredientMap[key] = ing
                }
            }
        }
        
        return ingredientMap.values.toList()
    }
}
