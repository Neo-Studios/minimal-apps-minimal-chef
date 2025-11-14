package com.neostudios.zest.util

import android.content.Context
import android.content.Intent

object SharingUtils {

    fun shareRecipe(context: Context, recipeName: String, recipeUrl: String, imageUri: Uri? = null) {
        val sendIntent: Intent = Intent().apply {
            action = if (imageUri != null) Intent.ACTION_SEND else Intent.ACTION_SEND
            type = if (imageUri != null) "image/*" else "text/plain"
            
            val shareText = buildString {
                append("🍳 $recipeName\n\n")
                append("Check out this delicious recipe!\n")
                append(recipeUrl)
            }
            
            putExtra(Intent.EXTRA_TEXT, shareText)
            putExtra(Intent.EXTRA_TITLE, recipeName)
            
            if (imageUri != null) {
                putExtra(Intent.EXTRA_STREAM, imageUri)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
        }

        val shareIntent = Intent.createChooser(sendIntent, "Share Recipe")
        context.startActivity(shareIntent)
    }
    
    fun shareShoppingList(context: Context, items: List<String>) {
        val listText = buildString {
            append("🛒 Shopping List\n\n")
            items.forEachIndexed { index, item ->
                append("${index + 1}. $item\n")
            }
            append("\nShared from Zest")
        }
        
        val sendIntent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, listText)
            putExtra(Intent.EXTRA_TITLE, "Shopping List")
            type = "text/plain"
        }
        
        context.startActivity(Intent.createChooser(sendIntent, "Share Shopping List"))
    }
    
    fun shareMealPlan(context: Context, mealPlan: Map<String, List<String>>) {
        val planText = buildString {
            append("📅 Meal Plan\n\n")
            mealPlan.forEach { (date, meals) ->
                append("$date:\n")
                meals.forEach { meal ->
                    append("  • $meal\n")
                }
                append("\n")
            }
            append("Shared from Zest")
        }
        
        val sendIntent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, planText)
            putExtra(Intent.EXTRA_TITLE, "Meal Plan")
            type = "text/plain"
        }
        
        context.startActivity(Intent.createChooser(sendIntent, "Share Meal Plan"))
    }
}
