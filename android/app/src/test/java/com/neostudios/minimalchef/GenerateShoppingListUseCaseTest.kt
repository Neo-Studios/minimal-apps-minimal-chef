package com.neostudios.minimalchef

import com.neostudios.minimalchef.domain.model.Ingredient
import com.neostudios.minimalchef.domain.model.Recipe
import com.neostudios.minimalchef.domain.usecase.GenerateShoppingListUseCase
import org.junit.Assert.assertEquals
import org.junit.Test

class GenerateShoppingListUseCaseTest {
    
    @Test
    fun `combines duplicate ingredients`() {
        val useCase = GenerateShoppingListUseCase()
        val recipes = listOf(
            Recipe(name = "Recipe 1", ingredients = listOf(Ingredient("flour", "2", "cups"))),
            Recipe(name = "Recipe 2", ingredients = listOf(Ingredient("flour", "1", "cup")))
        )
        
        val result = useCase(recipes)
        
        assertEquals(1, result.size)
        assertEquals("flour", result[0].name)
    }
}
