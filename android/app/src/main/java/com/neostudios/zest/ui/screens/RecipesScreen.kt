package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import com.neostudios.zest.ui.components.HeroCard
import com.neostudios.zest.ui.navigation.Screen

@Composable
fun RecipesScreen(
    navController: NavController,
    viewModel: RecipesViewModel = hiltViewModel()
) {
    val searchQuery by viewModel.searchQuery.collectAsStateWithLifecycle()
    val filteredRecipes = viewModel.getFilteredRecipes()
    
    Column(modifier = Modifier.fillMaxSize()) {
        OutlinedTextField(
            value = searchQuery,
            onValueChange = { viewModel.updateSearch(it) },
            placeholder = { Text("Search recipes...") },
            modifier = Modifier.fillMaxWidth().padding(16.dp)
        )
        
        LazyColumn(modifier = Modifier.fillMaxSize()) {
            items(filteredRecipes) { recipe ->
                HeroCard(
                    onClick = { navController.navigate(Screen.RecipeDetail.createRoute(recipe.id)) },
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
