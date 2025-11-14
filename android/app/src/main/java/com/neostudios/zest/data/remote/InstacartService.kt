package com.neostudios.zest.data.remote

import android.content.Context
import android.content.Intent
import android.net.Uri
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class InstacartService @Inject constructor(
    @ApplicationContext private val context: Context
) {
    companion object {
        private const val INSTACART_PACKAGE = "com.instacart.client"
        private const val INSTACART_WEB_URL = "https://www.instacart.com"
    }
    
    fun sendToInstacart(ingredients: List<String>) {
        val searchQuery = ingredients.joinToString(", ")
        val encodedQuery = Uri.encode(searchQuery)
        
        // Try to open Instacart app first
        val appIntent = context.packageManager.getLaunchIntentForPackage(INSTACART_PACKAGE)
        
        if (appIntent != null) {
            // Open Instacart app
            appIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(appIntent)
        } else {
            // Fall back to web browser
            val webIntent = Intent(Intent.ACTION_VIEW).apply {
                data = Uri.parse("$INSTACART_WEB_URL/store/search?query=$encodedQuery")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            context.startActivity(webIntent)
        }
    }
    
    fun isInstacartInstalled(): Boolean {
        return try {
            context.packageManager.getPackageInfo(INSTACART_PACKAGE, 0)
            true
        } catch (e: Exception) {
            false
        }
    }
}
