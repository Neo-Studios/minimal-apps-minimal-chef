package com.neostudios.zest.data.remote

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.net.URL
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class RecipeImportService @Inject constructor() {
    
    suspend fun importFromUrl(url: String): Map<String, Any> = withContext(Dispatchers.IO) {
        val html = URL(url).readText()
        val titleRegex = "<title>(.*?)</title>".toRegex()
        val name = titleRegex.find(html)?.groupValues?.get(1) ?: "Imported Recipe"
        
        mapOf(
            "name" to name,
            "ingredients" to emptyList<String>(),
            "instructions" to emptyList<String>(),
            "prepTime" to 0,
            "cookTime" to 0,
            "servings" to 1
        )
    }
}
