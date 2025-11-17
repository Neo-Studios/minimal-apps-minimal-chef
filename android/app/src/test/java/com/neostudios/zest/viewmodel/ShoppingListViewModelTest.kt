package com.neostudios.zest.viewmodel

import com.neostudios.zest.data.repository.ShoppingListRepository
import com.neostudios.zest.domain.model.ShoppingListItem
import com.neostudios.zest.ui.screens.ShoppingListViewModel
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.test.setMain
import org.junit.Before
import org.junit.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue

@ExperimentalCoroutinesApi
class ShoppingListViewModelTest {

    private lateinit var viewModel: ShoppingListViewModel
    private val shoppingListRepository: ShoppingListRepository = mockk()
    private val testDispatcher = UnconfinedTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        coEvery { shoppingListRepository.getShoppingList() } returns emptyList()
        viewModel = ShoppingListViewModel(shoppingListRepository)
    }

    @Test
    fun `loadShoppingList updates uiState with items`() = runTest {
        val mockItems = listOf(ShoppingListItem(id = "1", name = "Milk", quantity = "1 gallon", category = "Dairy", checked = false))
        coEvery { shoppingListRepository.getShoppingList() } returns mockItems

        viewModel.loadShoppingList()

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertEquals(mockItems, uiState.items)
    }

    @Test
    fun `addItem reloads shopping list`() = runTest {
        val newItem = ShoppingListItem(name = "Bread", quantity = "1 loaf", category = "Bakery", checked = false)
        coEvery { shoppingListRepository.addItem(any()) } returns Unit
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(newItem)

        viewModel.addItem(newItem.name, newItem.quantity, newItem.category)

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.items.contains(newItem))
    }

    @Test
    fun `toggleItemChecked reloads shopping list`() = runTest {
        val item = ShoppingListItem(id = "1", name = "Milk", quantity = "1 gallon", category = "Dairy", checked = false)
        val updatedItem = item.copy(checked = true)
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(item) // Initial load
        coEvery { shoppingListRepository.updateItem(updatedItem) } returns Unit
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(updatedItem) // After toggle

        viewModel.loadShoppingList() // Initial load
        viewModel.toggleItemChecked(item)

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.items.first().checked)
    }

    @Test
    fun `deleteItem reloads shopping list`() = runTest {
        val item = ShoppingListItem(id = "1", name = "Milk", quantity = "1 gallon", category = "Dairy", checked = false)
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(item) // Initial load
        coEvery { shoppingListRepository.deleteItem("1") } returns Unit
        coEvery { shoppingListRepository.getShoppingList() } returns emptyList() // After delete

        viewModel.loadShoppingList() // Initial load
        viewModel.deleteItem("1")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.items.isEmpty())
    }

    @Test
    fun `clearCheckedItems reloads shopping list`() = runTest {
        val checkedItem = ShoppingListItem(id = "1", name = "Milk", quantity = "1 gallon", category = "Dairy", checked = true)
        val uncheckedItem = ShoppingListItem(id = "2", name = "Bread", quantity = "1 loaf", category = "Bakery", checked = false)
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(checkedItem, uncheckedItem) // Initial load
        coEvery { shoppingListRepository.clearCheckedItems() } returns Unit
        coEvery { shoppingListRepository.getShoppingList() } returns listOf(uncheckedItem) // After clear

        viewModel.loadShoppingList() // Initial load
        viewModel.clearCheckedItems()

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertEquals(1, uiState.items.size)
        assertEquals(uncheckedItem, uiState.items.first())
    }
}
