package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import com.neostudios.zest.ui.components.HeroCard
import com.neostudios.zest.ui.navigation.Screen

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RecipesScreen(
    navController: NavController,
    viewModel: RecipesViewModel = hiltViewModel()
) {
    val searchQuery by viewModel.searchQuery.collectAsStateWithLifecycle()
    val filteredRecipes = viewModel.getFilteredRecipes()
    val isLoading by viewModel.isLoading.collectAsStateWithLifecycle()
    val error by viewModel.error.collectAsStateWithLifecycle()

    var showAddRecipeDialog by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            TopAppBar(title = { Text("Recipes") })
        },
        floatingActionButton = {
            FloatingActionButton(onClick = { showAddRecipeDialog = true }) {
                Icon(Icons.Default.Add, contentDescription = "Add Recipe")
            }
        }
    ) { paddingValues ->
        Column(modifier = Modifier.fillMaxSize().padding(paddingValues)) {
            OutlinedTextField(
                value = searchQuery,
                onValueChange = { viewModel.updateSearch(it) },
                placeholder = { Text("Search recipes...") },
                modifier = Modifier.fillMaxWidth().padding(16.dp)
            )

            if (isLoading) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            } else if (error != null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Error: $error", color = MaterialTheme.colorScheme.error)
                }
            } else if (filteredRecipes.isEmpty()) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("No recipes found.", style = MaterialTheme.typography.headlineSmall)
                }
            } else {
                LazyColumn(modifier = Modifier.fillMaxSize()) {
                    items(filteredRecipes) { recipe ->
                        HeroCard(
                            onClick = { navController.navigate(Screen.RecipeDetail.createRoute(recipe.id!!)) },
                            modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp)
                        ) {
                            Column(modifier = Modifier.padding(20.dp)) {
                                Text(
                                    recipe.name,
                                    style = MaterialTheme.typography.titleLarge,
                                    color = MaterialTheme.colorScheme.primary
                                )
                                Spacer(modifier = Modifier.height(4.dp))
                                Text(
                                    recipe.cuisineType,
                                    style = MaterialTheme.typography.bodyMedium,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                                Text(
                                    "${recipe.prepTime + recipe.cookTime} min • ${recipe.servings} servings",
                                    style = MaterialTheme.typography.labelMedium,
                                    color = MaterialTheme.colorScheme.tertiary
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    if (showAddRecipeDialog) {
        AlertDialog(
            onDismissRequest = { showAddRecipeDialog = false },
            title = { Text("Add New Recipe") },
            text = {
                AddRecipeScreen(
                    onSave = { name, ingredients, instructions, prepTime, cookTime, servings, imageUrl ->
                        viewModel.addRecipe(name, ingredients, instructions, prepTime, cookTime, servings, imageUrl)
                        showAddRecipeDialog = false
                    }
                )
            },
            confirmButton = { /* Handled by AddRecipeScreen's internal button */ },
            dismissButton = {
                TextButton(onClick = { showAddRecipeDialog = false }) {
                    Text("Cancel")
                }
            }
        )
    }
}
