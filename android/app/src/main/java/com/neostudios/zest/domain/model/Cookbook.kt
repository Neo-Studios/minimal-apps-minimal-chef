package com.neostudios.zest.domain.model

data class Cookbook(
    val id: String? = null,
    val name: String,
    val description: String? = null,
    val recipeIds: List<String> = emptyList(),
    val userId: String,
    val isPublic: Boolean = false,
    val coverImageUrl: String? = null,
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
) {
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "name" to name,
            "description" to description,
            "recipeIds" to recipeIds,
            "userId" to userId,
            "isPublic" to isPublic,
            "coverImageUrl" to coverImageUrl,
            "createdAt" to createdAt,
            "updatedAt" to updatedAt
        )
    }
    
    companion object {
        fun fromMap(map: Map<String, Any?>, id: String): Cookbook {
            return Cookbook(
                id = id,
                name = map["name"] as? String ?: "",
                description = map["description"] as? String,
                recipeIds = (map["recipeIds"] as? List<*>)?.mapNotNull { it as? String } ?: emptyList(),
                userId = map["userId"] as? String ?: "",
                isPublic = map["isPublic"] as? Boolean ?: false,
                coverImageUrl = map["coverImageUrl"] as? String,
                createdAt = map["createdAt"] as? Long ?: System.currentTimeMillis(),
                updatedAt = map["updatedAt"] as? Long ?: System.currentTimeMillis()
            )
        }
    }
}
