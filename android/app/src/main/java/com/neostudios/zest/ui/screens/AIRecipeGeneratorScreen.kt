package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.neostudios.zest.ai.AIManager
import kotlinx.coroutines.launch

@Composable
fun AIRecipeGeneratorScreen(aiManager: AIManager) {
    var ingredients by remember { mutableStateOf(listOf<String>()) }
    var currentIngredient by remember { mutableStateOf("") }
    var generatedRecipe by remember { mutableStateOf<String?>(null) }
    var isGenerating by remember { mutableStateOf(false) }
    val scope = rememberCoroutineScope()
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        Text(
            text = "AI Recipe Generator",
            style = MaterialTheme.typography.headlineLarge
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Ingredient input
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            OutlinedTextField(
                value = currentIngredient,
                onValueChange = { currentIngredient = it },
                label = { Text("Add ingredient") },
                modifier = Modifier.weight(1f),
                singleLine = true
            )
            
            IconButton(
                onClick = {
                    if (currentIngredient.isNotBlank()) {
                        ingredients = ingredients + currentIngredient
                        currentIngredient = ""
                    }
                }
            ) {
                Icon(Icons.Default.Add, contentDescription = "Add")
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Ingredients list
        if (ingredients.isNotEmpty()) {
            Card(modifier = Modifier.fillMaxWidth()) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text("Ingredients:", style = MaterialTheme.typography.titleMedium)
                    Spacer(modifier = Modifier.height(8.dp))
                    ingredients.forEach { ingredient ->
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            Text("• $ingredient")
                            IconButton(
                                onClick = { ingredients = ingredients - ingredient },
                                modifier = Modifier.size(24.dp)
                            ) {
                                Icon(Icons.Default.Close, contentDescription = "Remove", modifier = Modifier.size(16.dp))
                            }
                        }
                    }
                }
            }
            
            Spacer(modifier = Modifier.height(16.dp))
        }
        
        // Generate button
        Button(
            onClick = {
                scope.launch {
                    isGenerating = true
                    generatedRecipe = aiManager.generateRecipeSuggestion(ingredients)
                    isGenerating = false
                }
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = ingredients.isNotEmpty() && !isGenerating && aiManager.isAIAvailable()
        ) {
            if (isGenerating) {
                CircularProgressIndicator(
                    modifier = Modifier.size(24.dp),
                    color = MaterialTheme.colorScheme.onPrimary
                )
                Spacer(modifier = Modifier.width(8.dp))
            }
            Text(if (isGenerating) "Generating..." else "Generate Recipe with AI")
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Generated recipe
        generatedRecipe?.let { recipe ->
            Card(
                modifier = Modifier.fillMaxWidth(),
                colors = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer
                )
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text(
                            "Generated Recipe",
                            style = MaterialTheme.typography.titleLarge,
                            color = MaterialTheme.colorScheme.onPrimaryContainer
                        )
                        IconButton(onClick = { generatedRecipe = null }) {
                            Icon(Icons.Default.Close, contentDescription = "Close")
                        }
                    }
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        recipe,
                        style = MaterialTheme.typography.bodyLarge,
                        color = MaterialTheme.colorScheme.onPrimaryContainer
                    )
                    Spacer(modifier = Modifier.height(16.dp))
                    Button(
                        onClick = { /* Save recipe */ },
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Icon(Icons.Default.Save, contentDescription = null)
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Save Recipe")
                    }
                }
            }
        }
    }
}
