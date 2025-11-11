package com.neostudios.zest.data.repository

import android.content.Context
import com.neostudios.zest.data.health.HealthConnectManager
import com.neostudios.zest.domain.model.NutritionInfo
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.time.Instant

class NutritionRepository(context: Context) {
    
    private val healthConnectManager = HealthConnectManager(context)
    
    suspend fun logNutrition(nutrition: NutritionInfo, timestamp: Instant = Instant.now()): Boolean {
        return withContext(Dispatchers.IO) {
            if (healthConnectManager.isAvailable() && healthConnectManager.hasPermissions()) {
                healthConnectManager.syncNutrition(
                    calories = nutrition.calories.toDouble(),
                    protein = nutrition.protein,
                    carbs = nutrition.carbs,
                    fat = nutrition.fat,
                    timestamp = timestamp
                )
            } else {
                false
            }
        }
    }
    
    suspend fun getTodayNutrition(): NutritionInfo? {
        return withContext(Dispatchers.IO) {
            if (healthConnectManager.isAvailable() && healthConnectManager.hasPermissions()) {
                val data = healthConnectManager.getTodayNutrition()
                data?.let {
                    NutritionInfo(
                        calories = it.calories.toInt(),
                        protein = it.protein,
                        carbs = it.carbs,
                        fat = it.fat
                    )
                }
            } else {
                null
            }
        }
    }
    
    suspend fun isHealthConnectAvailable(): Boolean {
        return healthConnectManager.isAvailable()
    }
    
    suspend fun hasHealthPermissions(): Boolean {
        return healthConnectManager.hasPermissions()
    }
    
    fun getRequiredPermissions(): Set<String> {
        return healthConnectManager.getRequiredPermissions()
    }
}
