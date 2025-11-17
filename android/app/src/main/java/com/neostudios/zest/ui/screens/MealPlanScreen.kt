package com.neostudios.zest.ui.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.ArrowForward
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.neostudios.zest.domain.model.MealPlan
import com.neostudios.zest.domain.model.Recipe
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.TextStyle
import java.util.Locale

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MealPlanScreen(
    viewModel: MealPlanViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHostState) },
        topBar = {
            TopAppBar(
                title = { Text("Meal Plan") }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
                .padding(16.dp)
        ) {
            // Date Navigator
            DateNavigator(
                selectedDate = uiState.selectedDate,
                onDateChange = { viewModel.loadMealPlans(it) },
                onPreviousDay = { viewModel.changeSelectedDate(-1) },
                onNextDay = { viewModel.changeSelectedDate(1) }
            )

            Spacer(modifier = Modifier.height(16.dp))

            if (uiState.isLoading) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            } else if (uiState.error != null) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Error: ${uiState.error}", color = MaterialTheme.colorScheme.error)
                }
            } else {
                MealPlanContent(
                    mealPlans = uiState.mealPlans,
                    selectedDate = uiState.selectedDate,
                    allRecipes = uiState.allRecipes,
                    onAddRecipe = { date, mealType, recipeId ->
                        viewModel.addRecipeToMealPlan(date, mealType, recipeId)
                        scope.launch { snackbarHostState.showSnackbar("Recipe added!") }
                    },
                    onRemoveRecipe = { date, mealType, recipeId ->
                        viewModel.removeRecipeFromMealPlan(date, mealType, recipeId)
                        scope.launch { snackbarHostState.showSnackbar("Recipe removed!") }
                    }
                )
            }
        }
    }
}

@Composable
fun DateNavigator(
    selectedDate: LocalDate,
    onDateChange: (LocalDate) -> Unit,
    onPreviousDay: () -> Unit,
    onNextDay: () -> Unit
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        IconButton(onClick = onPreviousDay) {
            Icon(Icons.Default.ArrowBack, contentDescription = "Previous Day")
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = selectedDate.dayOfWeek.getDisplayName(TextStyle.FULL, Locale.getDefault()),
                style = MaterialTheme.typography.bodyLarge
            )
            Text(
                text = selectedDate.format(DateTimeFormatter.ofPattern("MMM dd, yyyy")),
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold
            )
            TextButton(onClick = { onDateChange(LocalDate.now()) }) {
                Text("Today")
            }
        }
        IconButton(onClick = onNextDay) {
            Icon(Icons.Default.ArrowForward, contentDescription = "Next Day")
        }
    }
}

@Composable
fun MealPlanContent(
    mealPlans: Map<LocalDate, MealPlan>,
    selectedDate: LocalDate,
    allRecipes: List<Recipe>,
    onAddRecipe: (LocalDate, String, String) -> Unit,
    onRemoveRecipe: (LocalDate, String, String) -> Unit
) {
    val currentMealPlan = mealPlans[selectedDate]

    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        item {
            MealSection(
                title = "Breakfast",
                mealType = "breakfast",
                mealPlan = currentMealPlan,
                allRecipes = allRecipes,
                selectedDate = selectedDate,
                onAddRecipe = onAddRecipe,
                onRemoveRecipe = onRemoveRecipe
            )
        }
        item {
            MealSection(
                title = "Lunch",
                mealType = "lunch",
                mealPlan = currentMealPlan,
                allRecipes = allRecipes,
                selectedDate = selectedDate,
                onAddRecipe = onAddRecipe,
                onRemoveRecipe = onRemoveRecipe
            )
        }
        item {
            MealSection(
                title = "Dinner",
                mealType = "dinner",
                mealPlan = currentMealPlan,
                allRecipes = allRecipes,
                selectedDate = selectedDate,
                onAddRecipe = onAddRecipe,
                onRemoveRecipe = onRemoveRecipe
            )
        }
        item {
            MealSection(
                title = "Snacks",
                mealType = "snacks",
                mealPlan = currentMealPlan,
                allRecipes = allRecipes,
                selectedDate = selectedDate,
                onAddRecipe = onAddRecipe,
                onRemoveRecipe = onRemoveRecipe
            )
        }
    }
}

@Composable
fun MealSection(
    title: String,
    mealType: String,
    mealPlan: MealPlan?,
    allRecipes: List<Recipe>,
    selectedDate: LocalDate,
    onAddRecipe: (LocalDate, String, String) -> Unit,
    onRemoveRecipe: (LocalDate, String, String) -> Unit
) {
    var showRecipePicker by remember { mutableStateOf(false) }

    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(text = title, style = MaterialTheme.typography.titleLarge)
                IconButton(onClick = { showRecipePicker = true }) {
                    Icon(Icons.Default.Add, contentDescription = "Add Recipe to $title")
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            val recipesForMeal = mealPlan?.meals?.get(mealType) ?: emptyList()
            if (recipesForMeal.isEmpty()) {
                Text("No recipes planned for $title", style = MaterialTheme.typography.bodyMedium)
            } else {
                Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                    recipesForMeal.forEach { recipeId ->
                        val recipe = allRecipes.find { it.id == recipeId }
                        if (recipe != null) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(recipe.name, style = MaterialTheme.typography.bodyLarge)
                                IconButton(onClick = { onRemoveRecipe(selectedDate, mealType, recipeId) }) {
                                    Icon(Icons.Default.Delete, contentDescription = "Remove ${recipe.name}")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    if (showRecipePicker) {
        RecipePickerDialog(
            recipes = allRecipes,
            onDismiss = { showRecipePicker = false },
            onRecipeSelected = { recipe ->
                recipe.id?.let { onAddRecipe(selectedDate, mealType, it) }
                showRecipePicker = false
            }
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RecipePickerDialog(
    recipes: List<Recipe>,
    onDismiss: () -> Unit,
    onRecipeSelected: (Recipe) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Select a Recipe") },
        text = {
            LazyColumn {
                items(recipes) { recipe ->
                    Text(
                        text = recipe.name,
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { onRecipeSelected(recipe) }
                            .padding(8.dp)
                    )
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}
