package com.neostudios.zest.data.health

import android.content.Context
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.time.Instant
import java.time.ZonedDateTime

class HealthConnectManager(private val context: Context) {
    
    private val healthConnectClient by lazy {
        HealthConnectClient.getOrCreate(context)
    }
    
    suspend fun isAvailable(): Boolean = withContext(Dispatchers.IO) {
        try {
            HealthConnectClient.getSdkStatus(context) == HealthConnectClient.SDK_AVAILABLE
        } catch (e: Exception) {
            false
        }
    }
    
    fun getRequiredPermissions(): Set<String> {
        return setOf(
            HealthPermission.getReadPermission(NutritionRecord::class),
            HealthPermission.getWritePermission(NutritionRecord::class)
        )
    }
    
    suspend fun hasPermissions(): Boolean = withContext(Dispatchers.IO) {
        try {
            val granted = healthConnectClient.permissionController.getGrantedPermissions()
            getRequiredPermissions().all { it in granted }
        } catch (e: Exception) {
            false
        }
    }
    
    suspend fun syncNutrition(
        calories: Double,
        protein: Double,
        carbs: Double,
        fat: Double,
        timestamp: Instant = Instant.now()
    ): Boolean = withContext(Dispatchers.IO) {
        try {
            if (!hasPermissions()) return@withContext false
            
            val record = NutritionRecord(
                startTime = timestamp,
                startZoneOffset = ZonedDateTime.now().offset,
                endTime = timestamp,
                endZoneOffset = ZonedDateTime.now().offset,
                energy = androidx.health.connect.client.units.Energy.kilocalories(calories),
                protein = androidx.health.connect.client.units.Mass.grams(protein),
                totalCarbohydrate = androidx.health.connect.client.units.Mass.grams(carbs),
                totalFat = androidx.health.connect.client.units.Mass.grams(fat),
                metadata = Metadata(
                    dataOrigin = androidx.health.connect.client.records.metadata.DataOrigin("com.neostudios.zest")
                )
            )
            
            healthConnectClient.insertRecords(listOf(record))
            true
        } catch (e: Exception) {
            false
        }
    }
    
    suspend fun getTodayNutrition(): NutritionData? = withContext(Dispatchers.IO) {
        try {
            if (!hasPermissions()) return@withContext null
            
            val startOfDay = ZonedDateTime.now().toLocalDate().atStartOfDay(ZonedDateTime.now().zone)
            val endOfDay = startOfDay.plusDays(1)
            
            val request = ReadRecordsRequest(
                recordType = NutritionRecord::class,
                timeRangeFilter = TimeRangeFilter.between(
                    startOfDay.toInstant(),
                    endOfDay.toInstant()
                )
            )
            
            val response = healthConnectClient.readRecords(request)
            
            var totalCalories = 0.0
            var totalProtein = 0.0
            var totalCarbs = 0.0
            var totalFat = 0.0
            
            response.records.forEach { record ->
                totalCalories += record.energy?.inKilocalories ?: 0.0
                totalProtein += record.protein?.inGrams ?: 0.0
                totalCarbs += record.totalCarbohydrate?.inGrams ?: 0.0
                totalFat += record.totalFat?.inGrams ?: 0.0
            }
            
            NutritionData(totalCalories, totalProtein, totalCarbs, totalFat)
        } catch (e: Exception) {
            null
        }
    }
}

data class NutritionData(
    val calories: Double,
    val protein: Double,
    val carbs: Double,
    val fat: Double
)
