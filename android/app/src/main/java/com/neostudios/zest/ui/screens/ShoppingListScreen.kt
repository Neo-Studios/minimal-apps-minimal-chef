package com.neostudios.zest.ui.screens

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.neostudios.zest.domain.model.ShoppingListItem

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ShoppingListScreen(
    viewModel: ShoppingListViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    var showAddItemDialog by remember { mutableStateOf(false) }
    var newItemName by remember { mutableStateOf("") }
    var newItemQuantity by remember { mutableStateOf("") }
    var newItemCategory by remember { mutableStateOf("") }

    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHostState) },
        topBar = {
            TopAppBar(
                title = { Text("Shopping List") },
                actions = {
                    IconButton(onClick = { viewModel.clearCheckedItems() }) {
                        Icon(Icons.Default.Delete, contentDescription = "Clear Checked Items")
                    }
                }
            )
        },
        floatingActionButton = {
            FloatingActionButton(onClick = { showAddItemDialog = true }) {
                Icon(Icons.Default.Add, contentDescription = "Add Item")
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
            } else if (uiState.items.isEmpty()) {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Your shopping list is empty!", style = MaterialTheme.typography.headlineSmall)
                }
            } else {
                ShoppingListContent(
                    items = uiState.items,
                    onToggleChecked = { viewModel.toggleItemChecked(it) },
                    onDeleteItem = { viewModel.deleteItem(it) }
                )
            }
        }
    }

    if (showAddItemDialog) {
        AddItemDialog(
            itemName = newItemName,
            onItemNameChange = { newItemName = it },
            itemQuantity = newItemQuantity,
            onItemQuantityChange = { newItemQuantity = it },
            itemCategory = newItemCategory,
            onItemCategoryChange = { newItemCategory = it },
            onDismiss = {
                showAddItemDialog = false
                newItemName = ""
                newItemQuantity = ""
                newItemCategory = ""
            },
            onAddItem = { name, quantity, category ->
                viewModel.addItem(name, quantity, category)
                showAddItemDialog = false
                newItemName = ""
                newItemQuantity = ""
                newItemCategory = ""
                scope.launch { snackbarHostState.showSnackbar("Item added!") }
            }
        )
    }
}

@Composable
fun ShoppingListContent(
    items: List<ShoppingListItem>,
    onToggleChecked: (ShoppingListItem) -> Unit,
    onDeleteItem: (String) -> Unit
) {
    val groupedItems = items.groupBy { it.category ?: "Uncategorized" }

    LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        groupedItems.forEach { (category, categoryItems) ->
            item {
                Text(
                    text = category,
                    style = MaterialTheme.typography.titleMedium,
                    modifier = Modifier.padding(vertical = 8.dp)
                )
            }
            items(categoryItems) { item ->
                ShoppingListItemRow(
                    item = item,
                    onToggleChecked = onToggleChecked,
                    onDeleteItem = onDeleteItem
                )
            }
        }
    }
}

@Composable
fun ShoppingListItemRow(
    item: ShoppingListItem,
    onToggleChecked: (ShoppingListItem) -> Unit,
    onDeleteItem: (String) -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onToggleChecked(item) }
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Checkbox(checked = item.checked, onCheckedChange = { onToggleChecked(item) })
                Spacer(modifier = Modifier.width(8.dp))
                Column {
                    Text(
                        text = item.name,
                        style = MaterialTheme.typography.bodyLarge,
                        color = if (item.checked) MaterialTheme.colorScheme.onSurfaceVariant else MaterialTheme.colorScheme.onSurface
                    )
                    if (item.quantity.isNotBlank()) {
                        Text(
                            text = item.quantity,
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
            }
            IconButton(onClick = { item.id?.let { onDeleteItem(it) } }) {
                Icon(Icons.Default.Delete, contentDescription = "Delete ${item.name}")
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddItemDialog(
    itemName: String,
    onItemNameChange: (String) -> Unit,
    itemQuantity: String,
    onItemQuantityChange: (String) -> Unit,
    itemCategory: String,
    onItemCategoryChange: (String) -> Unit,
    onDismiss: () -> Unit,
    onAddItem: (String, String, String?) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Add New Item") },
        text = {
            Column {
                OutlinedTextField(
                    value = itemName,
                    onValueChange = onItemNameChange,
                    label = { Text("Item Name") },
                    modifier = Modifier.fillMaxWidth()
                )
                Spacer(modifier = Modifier.height(8.dp))
                OutlinedTextField(
                    value = itemQuantity,
                    onValueChange = onItemQuantityChange,
                    label = { Text("Quantity (e.g., 2 lbs, 1 dozen)") },
                    modifier = Modifier.fillMaxWidth()
                )
                Spacer(modifier = Modifier.height(8.dp))
                OutlinedTextField(
                    value = itemCategory,
                    onValueChange = onItemCategoryChange,
                    label = { Text("Category (Optional)") },
                    modifier = Modifier.fillMaxWidth()
                )
            }
        },
        confirmButton = {
            TextButton(
                onClick = { onAddItem(itemName, itemQuantity, newItemCategory.ifBlank { null }) },
                enabled = itemName.isNotBlank()
            ) {
                Text("Add")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}
