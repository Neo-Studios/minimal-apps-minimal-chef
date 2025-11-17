package com.neostudios.zest.domain.model

import com.google.firebase.firestore.DocumentId
import com.google.firebase.firestore.ServerTimestamp
import java.util.Date

data class CollaborativeMealPlan(
    @DocumentId val id: String = "",
    val name: String = "",
    val ownerId: String = "",
    val members: List<CollaborativeMealPlanMember> = emptyList(),
    val mealPlanIds: List<String> = emptyList(), // References to individual meal plans
    @ServerTimestamp val createdAt: Date? = null,
    @ServerTimestamp val updatedAt: Date? = null
)

data class CollaborativeMealPlanMember(
    val userId: String = "",
    val role: String = "viewer" // "owner", "editor", "viewer"
)
