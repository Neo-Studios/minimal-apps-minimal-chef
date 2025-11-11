package com.neostudios.zest.domain.usecase

import com.neostudios.zest.domain.model.Ingredient
import com.neostudios.zest.domain.model.NutritionInfo

object NutritionCalculator {
    private val nutritionDatabase = mapOf(
        "chicken breast" to NutritionInfo(165, 31.0, 0.0, 3.6),
        "rice" to NutritionInfo(130, 2.7, 28.0, 0.3),
        "broccoli" to NutritionInfo(55, 3.7, 11.0, 0.6),
        "olive oil" to NutritionInfo(884, 0.0, 0.0, 100.0),
        "egg" to NutritionInfo(155, 13.0, 1.1, 11.0),
        "milk" to NutritionInfo(61, 3.2, 4.8, 3.3),
        "bread" to NutritionInfo(265, 9.0, 49.0, 3.2),
        "pasta" to NutritionInfo(131, 5.0, 25.0, 1.1),
        "tomato" to NutritionInfo(18, 0.9, 3.9, 0.2),
        "cheese" to NutritionInfo(402, 25.0, 1.3, 33.0)
    )
    
    fun calculate(ingredients: List<Ingredient>, servings: Int): NutritionInfo {
        var totalCalories = 0.0
        var totalProtein = 0.0
        var totalCarbs = 0.0
        var totalFat = 0.0
        
        ingredients.forEach { ing ->
            val nutrition = nutritionDatabase[ing.name.lowercase()]
            if (nutrition != null) {
                val factor = ing.amount / 100.0
                totalCalories += nutrition.calories * factor
                totalProtein += nutrition.protein * factor
                totalCarbs += nutrition.carbs * factor
                totalFat += nutrition.fat * factor
            }
        }
        
        return NutritionInfo(
            calories = (totalCalories / servings).toInt(),
            protein = (totalProtein / servings * 10).toInt() / 10.0,
            carbs = (totalCarbs / servings * 10).toInt() / 10.0,
            fat = (totalFat / servings * 10).toInt() / 10.0
        )
    }
    
    fun estimateCost(ingredients: List<Ingredient>): Double {
        return (ingredients.size * 2.5 * 100).toInt() / 100.0
    }
}
