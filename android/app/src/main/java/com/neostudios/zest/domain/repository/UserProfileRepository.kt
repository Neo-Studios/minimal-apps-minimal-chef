package com.neostudios.zest.domain.repository

interface UserProfileRepository {
    suspend fun getOnboardingStatus(userId: String): Boolean
    suspend fun setOnboardingStatus(userId: String, status: Boolean)
}
