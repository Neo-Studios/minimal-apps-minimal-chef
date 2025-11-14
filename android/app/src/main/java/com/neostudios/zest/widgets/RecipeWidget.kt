package com.neostudios.zest.widgets

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.action.clickable
import androidx.glance.action.actionStartActivity
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.layout.*
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import com.neostudios.zest.MainActivity
import com.neostudios.zest.R

data class Recipe(val title: String, val imageName: Int, val prepTime: Int, val servings: Int)

class RecipeWidget : GlanceAppWidget() {

    private val recipeOfTheDay = Recipe("Spaghetti Carbonara", R.drawable.recipe_placeholder, 15, 4)

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
                .padding(16.dp)
                .background(ColorProvider(R.color.widget_background))
                .clickable(actionStartActivity<MainActivity>()),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Image(
                provider = ImageProvider(recipe.imageName),
                contentDescription = recipe.title,
                modifier = GlanceModifier
                    .size(120.dp)
                    .padding(bottom = 12.dp)
            )
            
            Text(
                text = "Recipe of the Day",
                style = TextStyle(
                    fontSize = 12.sp,
                    fontWeight = FontWeight.Medium,
                    color = ColorProvider(R.color.widget_text_secondary)
                ),
                modifier = GlanceModifier.padding(bottom = 4.dp)
            )
            
            Text(
                text = recipe.title,
                style = TextStyle(
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    color = ColorProvider(R.color.widget_text_primary)
                ),
                modifier = GlanceModifier.padding(bottom = 8.dp)
            )
            
            Row(
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = GlanceModifier.padding(top = 4.dp)
            ) {
                Text(
                    text = "⏱️ ${recipe.prepTime}m",
                    style = TextStyle(
                        fontSize = 12.sp,
                        color = ColorProvider(R.color.widget_text_secondary)
                    ),
                    modifier = GlanceModifier.padding(end = 12.dp)
                )
                Text(
                    text = "🍽️ ${recipe.servings}",
                    style = TextStyle(
                        fontSize = 12.sp,
                        color = ColorProvider(R.color.widget_text_secondary)
                    )
                )
            }
        }
    }
}
