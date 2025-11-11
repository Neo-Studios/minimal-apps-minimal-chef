package com.neostudios.zest.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.neostudios.zest.domain.model.Ingredient

@Composable
fun AddRecipeScreen(onSave: (String, List<Ingredient>, List<String>, Int, Int, Int) -> Unit) {
    var name by remember { mutableStateOf("") }
    var prepTime by remember { mutableStateOf("") }
    var cookTime by remember { mutableStateOf("") }
    var servings by remember { mutableStateOf("") }
    var ingredients by remember { mutableStateOf(listOf(Ingredient())) }
    var instructions by remember { mutableStateOf(listOf("")) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState())
            .padding(16.dp)
    ) {
        Text("Add Recipe", style = MaterialTheme.typography.headlineLarge)
        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = name,
            onValueChange = { name = it },
            label = { Text("Recipe Name") },
            modifier = Modifier.fillMaxWidth()
        )
        Spacer(modifier = Modifier.height(8.dp))

        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            OutlinedTextField(
                value = prepTime,
                onValueChange = { prepTime = it },
                label = { Text("Prep (min)") },
                modifier = Modifier.weight(1f)
            )
            OutlinedTextField(
                value = cookTime,
                onValueChange = { cookTime = it },
                label = { Text("Cook (min)") },
                modifier = Modifier.weight(1f)
            )
            OutlinedTextField(
                value = servings,
                onValueChange = { servings = it },
                label = { Text("Servings") },
                modifier = Modifier.weight(1f)
            )
        }

        Spacer(modifier = Modifier.height(16.dp))
        Text("Ingredients", style = MaterialTheme.typography.titleLarge)
        ingredients.forEachIndexed { i, ing ->
            Row(horizontalArrangement = Arrangement.spacedBy(4.dp)) {
                OutlinedTextField(
                    value = ing.amount,
                    onValueChange = { ingredients = ingredients.toMutableList().apply { this[i] = ing.copy(amount = it) } },
                    label = { Text("Amount") },
                    modifier = Modifier.weight(1f)
                )
                OutlinedTextField(
                    value = ing.unit,
                    onValueChange = { ingredients = ingredients.toMutableList().apply { this[i] = ing.copy(unit = it) } },
                    label = { Text("Unit") },
                    modifier = Modifier.weight(1f)
                )
                OutlinedTextField(
                    value = ing.name,
                    onValueChange = { ingredients = ingredients.toMutableList().apply { this[i] = ing.copy(name = it) } },
                    label = { Text("Name") },
                    modifier = Modifier.weight(2f)
                )
            }
        }
        TextButton(onClick = { ingredients = ingredients + Ingredient() }) {
            Text("+ Add Ingredient")
        }

        Spacer(modifier = Modifier.height(16.dp))
        Text("Instructions", style = MaterialTheme.typography.titleLarge)
        instructions.forEachIndexed { i, step ->
            OutlinedTextField(
                value = step,
                onValueChange = { instructions = instructions.toMutableList().apply { this[i] = it } },
                label = { Text("Step ${i + 1}") },
                modifier = Modifier.fillMaxWidth()
            )
        }
        TextButton(onClick = { instructions = instructions + "" }) {
            Text("+ Add Step")
        }

        Button(
            onClick = {
                onSave(
                    name,
                    ingredients.filter { it.name.isNotEmpty() },
                    instructions.filter { it.isNotEmpty() },
                    prepTime.toIntOrNull() ?: 0,
                    cookTime.toIntOrNull() ?: 0,
                    servings.toIntOrNull() ?: 1
                )
            },
            modifier = Modifier.fillMaxWidth().padding(top = 16.dp)
        ) {
            Text("Save Recipe")
        }
    }
}
