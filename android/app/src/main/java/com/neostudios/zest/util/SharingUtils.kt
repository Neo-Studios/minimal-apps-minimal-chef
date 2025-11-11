package com.neostudios.zest.util

import android.content.Context
import android.content.Intent

object SharingUtils {

    fun shareRecipe(context: Context, recipeName: String, recipeUrl: String) {
        val sendIntent: Intent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, "Check out this recipe for $recipeName: $recipeUrl")
            type = "text/plain"
        }

        val shareIntent = Intent.createChooser(sendIntent, null)
        context.startActivity(shareIntent)
    }
}
