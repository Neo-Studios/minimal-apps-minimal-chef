package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.neostudios.zest.ui.navigation.Screen

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MealKitDetailScreen(
    mealKitId: String,
    navController: NavController,
    viewModel: MealKitViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()

    LaunchedEffect(mealKitId) {
        viewModel.loadMealKitDetail(mealKitId)
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(uiState.selectedMealKit?.name ?: "Meal Kit Details") },
                navigationIcon = {
                    IconButton(onClick = { navController.popBackStack() }) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(16.dp)
        ) {
            if (uiState.isLoading) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            } else if (uiState.error != null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Error: ${uiState.error}", color = MaterialTheme.colorScheme.error)
                }
            } else if (uiState.selectedMealKit == null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Meal kit not found.", style = MaterialTheme.typography.headlineSmall)
                }
            } else {
                val mealKit = uiState.selectedMealKit
                LazyColumn(modifier = Modifier.fillMaxSize()) {
                    item {
                        AsyncImage(
                            model = mealKit.imageUrl,
                            contentDescription = mealKit.name,
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(250.dp),
                            contentScale = ContentScale.Crop
                        )
                        Spacer(modifier = Modifier.height(16.dp))
                        Text(mealKit.name, style = MaterialTheme.typography.headlineLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                        Text(mealKit.description, style = MaterialTheme.typography.bodyLarge)
                        Spacer(modifier = Modifier.height(16.dp))
                        Text("Price: $${mealKit.price}", style = MaterialTheme.typography.headlineMedium)
                        Spacer(modifier = Modifier.height(16.dp))
                        Text("Recipes Included:", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                    }
                    items(mealKit.recipes) { mealKitRecipe ->
                        Card(modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)) {
                            Column(modifier = Modifier.padding(16.dp)) {
                                Text("Recipe ID: ${mealKitRecipe.recipeId}", style = MaterialTheme.typography.bodyLarge)
                                Text("Servings: ${mealKitRecipe.servings}", style = MaterialTheme.typography.bodyMedium)
                            }
                        }
                    }
                    item {
                        Spacer(modifier = Modifier.height(16.dp))
                        Text("Available Dates:", style = MaterialTheme.typography.titleLarge)
                        Spacer(modifier = Modifier.height(8.dp))
                        FlowRow(
                            modifier = Modifier.fillMaxWidth(),
                            mainAxisSpacing = 8.dp,
                            crossAxisSpacing = 8.dp
                        ) {
                            mealKit.availableDates.forEach { date ->
                                SuggestionChip(onClick = { /* Do nothing */ }, label = { Text(date) })
                            }
                        }
                        Spacer(modifier = Modifier.height(16.dp))
                        Button(onClick = { /* Add to cart logic */ }, modifier = Modifier.fillMaxWidth()) {
                            Text("Add to Cart")
                        }
                    }
                }
            }
        }
    }
}
