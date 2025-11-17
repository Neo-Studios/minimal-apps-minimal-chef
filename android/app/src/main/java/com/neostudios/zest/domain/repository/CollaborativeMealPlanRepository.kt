package com.neostudios.zest.domain.repository

import com.neostudios.zest.domain.model.CollaborativeMealPlan
import com.neostudios.zest.domain.model.CollaborativeMealPlanMember

interface CollaborativeMealPlanRepository {
    suspend fun getCollaborativeMealPlans(userId: String): List<CollaborativeMealPlan>
    suspend fun getCollaborativeMealPlan(id: String): CollaborativeMealPlan?
    suspend fun createCollaborativeMealPlan(name: String, ownerId: String): String
    suspend fun updateCollaborativeMealPlan(id: String, collaborativeMealPlan: CollaborativeMealPlan)
    suspend fun deleteCollaborativeMealPlan(id: String)
    suspend fun addMemberToCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember)
    suspend fun removeMemberFromCollaborativeMealPlan(planId: String, member: CollaborativeMealPlanMember)
    suspend fun addMealPlanToCollaborativePlan(planId: String, mealPlanId: String)
    suspend fun removeMealPlanFromCollaborativePlan(planId: String, mealPlanId: String)
}
