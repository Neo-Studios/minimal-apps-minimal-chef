package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Remove
import androidx.compose.material.icons.filled.Share
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.neostudios.zest.util.SharingUtils

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RecipeDetailScreen(
    recipeId: String,
    navController: NavController,
    viewModel: RecipesViewModel = hiltViewModel()
) {
    val recipe = viewModel.getRecipeById(recipeId)
    val context = LocalContext.current
    var servingMultiplier by remember { mutableStateOf(1f) }

    if (recipe != null) {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text(recipe.name) },
                    navigationIcon = {
                        IconButton(onClick = { navController.navigateUp() }) {
                            Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                        }
                    },
                    actions = {
                        IconButton(onClick = { 
                            viewModel.toggleFavorite(recipe)
                        }) {
                            Icon(if (recipe.isFavorite) Icons.Default.Favorite else Icons.Default.FavoriteBorder, contentDescription = "Favorite")
                        }
                        IconButton(onClick = { 
                            SharingUtils.shareRecipe(context, recipe.name, "https://zest.com/recipe/${recipe.id}")
                        }) {
                            Icon(Icons.Default.Share, contentDescription = "Share")
                        }
                    }
                )
            },
            floatingActionButton = {
                Column {
                    FloatingActionButton(onClick = { navController.navigate(Screen.CookingMode.createRoute(recipe.id!!)) }) {
                        Icon(Icons.Default.PlayArrow, contentDescription = "Start Cooking")
                    }
                    Spacer(modifier = Modifier.height(16.dp))
                    FloatingActionButton(onClick = { navController.navigate(Screen.ARCooking.createRoute(recipe.id!!)) }) {
                        Icon(Icons.Default.Camera, contentDescription = "Start AR Cooking")
                    }
                }
            }
        ) { paddingValues ->
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .verticalScroll(rememberScrollState())
                    .padding(paddingValues)
                    .padding(16.dp)
            ) {
                Card(modifier = Modifier.fillMaxWidth().padding(bottom = 16.dp)) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Row(modifier = Modifier.padding(vertical = 8.dp)) {
                            Text("⏱️ ${recipe.prepTime}m", modifier = Modifier.padding(end = 16.dp))
                            Text("🔥 ${recipe.cookTime}m", modifier = Modifier.padding(end = 16.dp))
                            Text("🍽️ ${recipe.servings}")
                        }
                    }
                }
                
                // Recipe Scaling Card
                Card(
                    modifier = Modifier.fillMaxWidth().padding(bottom = 16.dp),
                    colors = CardDefaults.cardColors(
                        containerColor = MaterialTheme.colorScheme.surfaceVariant
                    )
                ) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text(
                            "Scale Recipe",
                            style = MaterialTheme.typography.titleMedium
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            IconButton(
                                onClick = { if (servingMultiplier > 0.5f) servingMultiplier -= 0.5f }
                            ) {
                                Icon(Icons.Default.Remove, "Decrease")
                            }
                            Text(
                                "${(recipe.servings * servingMultiplier).toInt()} servings (×$servingMultiplier)",
                                style = MaterialTheme.typography.bodyLarge
                            )
                            IconButton(
                                onClick = { servingMultiplier += 0.5f }
                            ) {
                                Icon(Icons.Default.Add, "Increase")
                            }
                        }
                        if (servingMultiplier != 1f) {
                            TextButton(onClick = { servingMultiplier = 1f }) {
                                Text("Reset")
                            }
                        }
                    }
                }
                
                Card(modifier = Modifier.fillMaxWidth().padding(bottom = 16.dp)) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text("Ingredients", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                        recipe.ingredients.forEach { ing ->
                            val scaledAmount = ing.amount.toFloatOrNull()?.let { it * servingMultiplier }
                            val displayAmount = scaledAmount?.let { 
                                if (it % 1 == 0f) it.toInt().toString() else String.format("%.2f", it)
                            } ?: ing.amount
                            Text("• $displayAmount ${ing.unit} ${ing.name}")
                        }
                    }
                }
                
                Card(modifier = Modifier.fillMaxWidth()) {
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text("Instructions", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                        recipe.instructions.forEachIndexed { i, step ->
                            Text("${i + 1}. $step", modifier = Modifier.padding(bottom = 8.dp))
                        }
                    }
                }
            }
        }
    } else {
        Box(modifier = Modifier.fillMaxSize()) {
            Text("Recipe not found", modifier = Modifier.align(Alignment.Center))
        }
    }
}
