package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.neostudios.zest.domain.model.NutritionInfo

data class DailyNutrition(val date: String, val nutrition: NutritionInfo)

@Composable
fun NutritionDashboardScreen(weeklyData: List<DailyNutrition>) {
    val totals = weeklyData.fold(NutritionInfo(0, 0.0, 0.0, 0.0)) { acc, day ->
        NutritionInfo(
            calories = acc.calories + day.nutrition.calories,
            protein = acc.protein + day.nutrition.protein,
            carbs = acc.carbs + day.nutrition.carbs,
            fat = acc.fat + day.nutrition.fat
        )
    }
    
    val averages = NutritionInfo(
        calories = totals.calories / weeklyData.size,
        protein = (totals.protein / weeklyData.size * 10).toInt() / 10.0,
        carbs = (totals.carbs / weeklyData.size * 10).toInt() / 10.0,
        fat = (totals.fat / weeklyData.size * 10).toInt() / 10.0
    )
    
    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        item {
            Text(
                text = "Nutrition Dashboard",
                style = MaterialTheme.typography.headlineLarge
            )
        }
        
        item {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                NutritionCard(
                    label = "Avg Calories",
                    value = "${averages.calories}",
                    color = MaterialTheme.colorScheme.primary,
                    modifier = Modifier.weight(1f)
                )
                NutritionCard(
                    label = "Avg Protein",
                    value = "${averages.protein}g",
                    color = MaterialTheme.colorScheme.secondary,
                    modifier = Modifier.weight(1f)
                )
            }
        }
        
        item {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                NutritionCard(
                    label = "Avg Carbs",
                    value = "${averages.carbs}g",
                    color = MaterialTheme.colorScheme.tertiary,
                    modifier = Modifier.weight(1f)
                )
                NutritionCard(
                    label = "Avg Fat",
                    value = "${averages.fat}g",
                    color = MaterialTheme.colorScheme.error,
                    modifier = Modifier.weight(1f)
                )
            }
        }
        
        item {
            Text(
                text = "Weekly Breakdown",
                style = MaterialTheme.typography.titleLarge
            )
        }
        
        items(weeklyData) { day ->
            Card(modifier = Modifier.fillMaxWidth()) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text(text = day.date)
                    Text(text = "${day.nutrition.calories} cal", style = MaterialTheme.typography.titleMedium)
                }
            }
        }
    }
}

@Composable
fun NutritionCard(label: String, value: String, color: androidx.compose.ui.graphics.Color, modifier: Modifier = Modifier) {
    Card(
        modifier = modifier,
        colors = CardDefaults.cardColors(containerColor = color.copy(alpha = 0.1f))
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(text = label, style = MaterialTheme.typography.bodySmall)
            Text(text = value, style = MaterialTheme.typography.headlineMedium, color = color)
        }
    }
}
