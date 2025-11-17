package com.neostudios.zest.ui.screens

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.neostudios.zest.domain.model.ShoppingListItem
import com.neostudios.zest.data.repository.ShoppingListRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ShoppingListViewModel @Inject constructor(
    private val shoppingListRepository: ShoppingListRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(ShoppingListUiState())
    val uiState: StateFlow<ShoppingListUiState> = _uiState

    init {
        loadShoppingList()
    }

    fun loadShoppingList() {
        _uiState.value = _uiState.value.copy(isLoading = true)
        viewModelScope.launch {
            try {
                val items = shoppingListRepository.getShoppingList()
                _uiState.value = _uiState.value.copy(
                    items = items,
                    isLoading = false
                )
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    error = e.localizedMessage,
                    isLoading = false
                )
            }
        }
    }

    fun addItem(name: String, quantity: String, category: String?) {
        viewModelScope.launch {
            try {
                val finalCategory = category?.ifBlank { null } ?: ShoppingListCategorizer.categorizeItem(name)
                val newItem = ShoppingListItem(
                    name = name,
                    quantity = quantity,
                    category = finalCategory,
                    checked = false
                )
                shoppingListRepository.addItem(newItem)
                loadShoppingList() // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun toggleItemChecked(item: ShoppingListItem) {
        viewModelScope.launch {
            try {
                shoppingListRepository.updateItem(item.copy(checked = !item.checked))
                loadShoppingList() // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun deleteItem(itemId: String) {
        viewModelScope.launch {
            try {
                shoppingListRepository.deleteItem(itemId)
                loadShoppingList() // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }

    fun clearCheckedItems() {
        viewModelScope.launch {
            try {
                shoppingListRepository.clearCheckedItems()
                loadShoppingList() // Reload to update UI
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(error = e.localizedMessage)
            }
        }
    }
}

data class ShoppingListUiState(
    val items: List<ShoppingListItem> = emptyList(),
    val isLoading: Boolean = false,
    val error: String? = null
)
