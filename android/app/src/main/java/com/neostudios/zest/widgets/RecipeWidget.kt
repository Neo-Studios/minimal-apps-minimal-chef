
package com.neostudios.zest.widgets

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.padding
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.neostudios.zest.R

data class Recipe(val title: String, val imageName: Int)

class RecipeWidget : GlanceAppWidget() {

    private val recipeOfTheDay = Recipe("Spaghetti Carbonara", R.drawable.recipe_placeholder)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            RecipeWidgetContent(recipeOfTheDay)
        }
    }

    @Composable
    private fun RecipeWidgetContent(recipe: Recipe) {
        Column(
            modifier = GlanceModifier
                .fillMaxSize()
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Image(
                provider = ImageProvider(recipe.imageName),
                contentDescription = recipe.title,
                modifier = GlanceModifier.padding(bottom = 8.dp)
            )
            Text(
                text = recipe.title,
                style = TextStyle(fontWeight = FontWeight.Bold)
            )
        }
    }
}
