package com.neostudios.zest.domain.usecase

object UnitConverter {
    private val conversions = mapOf(
        "g" to mapOf("g" to 1.0, "kg" to 0.001, "oz" to 0.035274, "lb" to 0.00220462),
        "kg" to mapOf("g" to 1000.0, "kg" to 1.0, "oz" to 35.274, "lb" to 2.20462),
        "oz" to mapOf("g" to 28.3495, "kg" to 0.0283495, "oz" to 1.0, "lb" to 0.0625),
        "lb" to mapOf("g" to 453.592, "kg" to 0.453592, "oz" to 16.0, "lb" to 1.0),
        "ml" to mapOf("ml" to 1.0, "l" to 0.001, "cup" to 0.00422675, "tbsp" to 0.067628, "tsp" to 0.202884),
        "l" to mapOf("ml" to 1000.0, "l" to 1.0, "cup" to 4.22675, "tbsp" to 67.628, "tsp" to 202.884),
        "cup" to mapOf("ml" to 236.588, "l" to 0.236588, "cup" to 1.0, "tbsp" to 16.0, "tsp" to 48.0),
        "tbsp" to mapOf("ml" to 14.7868, "l" to 0.0147868, "cup" to 0.0625, "tbsp" to 1.0, "tsp" to 3.0),
        "tsp" to mapOf("ml" to 4.92892, "l" to 0.00492892, "cup" to 0.0208333, "tbsp" to 0.333333, "tsp" to 1.0)
    )
    
    fun convert(amount: Double, fromUnit: String, toUnit: String): Double {
        if (fromUnit == toUnit) return amount
        val conversion = conversions[fromUnit]?.get(toUnit) ?: return amount
        return (amount * conversion * 100).toInt() / 100.0
    }
    
    fun scaleRecipe(amount: Double, originalServings: Int, newServings: Int): Double {
        val scale = newServings.toDouble() / originalServings
        return (amount * scale * 100).toInt() / 100.0
    }
}
