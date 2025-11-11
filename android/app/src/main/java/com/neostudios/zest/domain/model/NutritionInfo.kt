package com.neostudios.zest.domain.model

data class NutritionInfo(
    val calories: Int,
    val protein: Double,
    val carbs: Double,
    val fat: Double,
    val fiber: Double? = null,
    val sugar: Double? = null,
    val sodium: Double? = null
) {
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "calories" to calories,
            "protein" to protein,
            "carbs" to carbs,
            "fat" to fat,
            "fiber" to fiber,
            "sugar" to sugar,
            "sodium" to sodium
        )
    }
    
    companion object {
        fun fromMap(map: Map<String, Any?>): NutritionInfo {
            return NutritionInfo(
                calories = (map["calories"] as? Number)?.toInt() ?: 0,
                protein = (map["protein"] as? Number)?.toDouble() ?: 0.0,
                carbs = (map["carbs"] as? Number)?.toDouble() ?: 0.0,
                fat = (map["fat"] as? Number)?.toDouble() ?: 0.0,
                fiber = (map["fiber"] as? Number)?.toDouble(),
                sugar = (map["sugar"] as? Number)?.toDouble(),
                sodium = (map["sodium"] as? Number)?.toDouble()
            )
        }
    }
}
