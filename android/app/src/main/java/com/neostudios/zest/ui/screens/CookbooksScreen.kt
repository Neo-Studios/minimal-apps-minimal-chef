package com.neostudios.zest.ui.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.neostudios.zest.domain.model.Cookbook
import com.neostudios.zest.domain.model.Recipe

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CookbooksScreen(
    viewModel: CookbooksViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    var showCreateCookbookDialog by remember { mutableStateOf(false) }
    var showEditCookbookDialog by remember { mutableStateOf(false) }
    var showAddRecipeDialog by remember { mutableStateOf(false) }
    var selectedCookbook by remember { mutableStateOf<Cookbook?>(null) }

    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHostState) },
        topBar = {
            TopAppBar(
                title = { Text("Cookbooks") }
            )
        },
        floatingActionButton = {
            FloatingActionButton(onClick = { showCreateCookbookDialog = true }) {
                Icon(Icons.Default.Add, contentDescription = "Create Cookbook")
            }
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
            } else if (uiState.cookbooks.isEmpty()) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("No cookbooks yet! Create one to get started.", style = MaterialTheme.typography.headlineSmall)
                }
            } else {
                LazyColumn(verticalArrangement = Arrangement.spacedBy(16.dp)) {
                    items(uiState.cookbooks) { cookbook ->
                        CookbookCard(
                            cookbook = cookbook,
                            allRecipes = uiState.allRecipes,
                            onEdit = {
                                selectedCookbook = it
                                showEditCookbookDialog = true
                            },
                            onDelete = {
                                viewModel.deleteCookbook(it.id!!)
                                scope.launch { snackbarHostState.showSnackbar("Cookbook deleted!") }
                            },
                            onAddRecipe = {
                                selectedCookbook = it
                                showAddRecipeDialog = true
                            },
                            onRemoveRecipe = { cbId, recipeId ->
                                viewModel.removeRecipeFromCookbook(cbId, recipeId)
                                scope.launch { snackbarHostState.showSnackbar("Recipe removed from cookbook!") }
                            }
                        )
                    }
                }
            }
        }
    }

    if (showCreateCookbookDialog) {
        CreateEditCookbookDialog(
            onDismiss = { showCreateCookbookDialog = false },
            onConfirm = { name, description, isPublic ->
                viewModel.createCookbook(name, description, isPublic)
                showCreateCookbookDialog = false
                scope.launch { snackbarHostState.showSnackbar("Cookbook created!") }
            }
        )
    }

    if (showEditCookbookDialog && selectedCookbook != null) {
        CreateEditCookbookDialog(
            cookbook = selectedCookbook,
            onDismiss = { showEditCookbookDialog = false; selectedCookbook = null },
            onConfirm = { name, description, isPublic ->
                viewModel.updateCookbook(selectedCookbook!!.copy(name = name, description = description, isPublic = isPublic))
                showEditCookbookDialog = false
                selectedCookbook = null
                scope.launch { snackbarHostState.showSnackbar("Cookbook updated!") }
            }
        )
    }

    if (showAddRecipeDialog && selectedCookbook != null) {
        AddRecipeToCookbookDialog(
            cookbook = selectedCookbook!!,
            allRecipes = uiState.allRecipes,
            onDismiss = { showAddRecipeDialog = false; selectedCookbook = null },
            onAddRecipe = { cookbookId, recipeId ->
                viewModel.addRecipeToCookbook(cookbookId, recipeId)
                showAddRecipeDialog = false
                selectedCookbook = null
                scope.launch { snackbarHostState.showSnackbar("Recipe added to cookbook!") }
            }
        )
    }
}

@Composable
fun CookbookCard(
    cookbook: Cookbook,
    allRecipes: List<Recipe>,
    onEdit: (Cookbook) -> Unit,
    onDelete: (Cookbook) -> Unit,
    onAddRecipe: (Cookbook) -> Unit,
    onRemoveRecipe: (String, String) -> Unit
) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(text = cookbook.name, style = MaterialTheme.typography.titleLarge)
                Row {
                    IconButton(onClick = { onEdit(cookbook) }) {
                        Icon(Icons.Default.Edit, contentDescription = "Edit Cookbook")
                    }
                    IconButton(onClick = { onDelete(cookbook) }) {
                        Icon(Icons.Default.Delete, contentDescription = "Delete Cookbook")
                    }
                }
            }
            Spacer(modifier = Modifier.height(8.dp))
            Text(text = cookbook.description, style = MaterialTheme.typography.bodyMedium)
            Spacer(modifier = Modifier.height(8.dp))
            Text(text = "Recipes (${cookbook.recipeIds.size})", style = MaterialTheme.typography.titleMedium)
            Spacer(modifier = Modifier.height(4.dp))
            if (cookbook.recipeIds.isEmpty()) {
                Text("No recipes in this cookbook yet.", style = MaterialTheme.typography.bodySmall)
            } else {
                Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                    cookbook.recipeIds.forEach { recipeId ->
                        val recipe = allRecipes.find { it.id == recipeId }
                        if (recipe != null) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(recipe.name, style = MaterialTheme.typography.bodyMedium)
                                IconButton(onClick = { onRemoveRecipe(cookbook.id!!, recipeId) }) {
                                    Icon(Icons.Default.Delete, contentDescription = "Remove ${recipe.name}")
                                }
                            }
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.height(8.dp))
            Button(onClick = { onAddRecipe(cookbook) }, modifier = Modifier.fillMaxWidth()) {
                Text("Add Recipe")
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CreateEditCookbookDialog(
    cookbook: Cookbook? = null,
    onDismiss: () -> Unit,
    onConfirm: (String, String, Boolean) -> Unit
) {
    var name by remember { mutableStateOf(cookbook?.name ?: "") }
    var description by remember { mutableStateOf(cookbook?.description ?: "") }
    var isPublic by remember { mutableStateOf(cookbook?.isPublic ?: false) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(if (cookbook == null) "Create New Cookbook" else "Edit Cookbook") },
        text = {
            Column {
                OutlinedTextField(
                    value = name,
                    onValueChange = { name = it },
                    label = { Text("Cookbook Name") },
                    modifier = Modifier.fillMaxWidth()
                )
                Spacer(modifier = Modifier.height(8.dp))
                OutlinedTextField(
                    value = description,
                    onValueChange = { description = it },
                    label = { Text("Description (Optional)") },
                    modifier = Modifier.fillMaxWidth()
                )
                Spacer(modifier = Modifier.height(8.dp))
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Checkbox(checked = isPublic, onCheckedChange = { isPublic = it })
                    Text("Public Cookbook")
                }
            }
        },
        confirmButton = {
            TextButton(
                onClick = { onConfirm(name, description, isPublic) },
                enabled = name.isNotBlank()
            ) {
                Text(if (cookbook == null) "Create" else "Save")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddRecipeToCookbookDialog(
    cookbook: Cookbook,
    allRecipes: List<Recipe>,
    onDismiss: () -> Unit,
    onAddRecipe: (String, String) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Add Recipe to ${cookbook.name}") },
        text = {
            LazyColumn {
                items(allRecipes.filter { it.id !in cookbook.recipeIds }) { recipe ->
                    Text(
                        text = recipe.name,
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { recipe.id?.let { onAddRecipe(cookbook.id!!, it) } }
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
