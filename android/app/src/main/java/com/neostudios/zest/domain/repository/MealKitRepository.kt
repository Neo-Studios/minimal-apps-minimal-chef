package com.neostudios.zest.domain.repository

import com.neostudios.zest.domain.model.MealKit

interface MealKitRepository {
    suspend fun getMealKits(): List<MealKit>
    suspend fun getMealKit(id: String): MealKit?
    suspend fun getAvailableMealKits(date: String): List<MealKit>
}
