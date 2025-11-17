package com.neostudios.zest.viewmodel

import com.neostudios.zest.data.repository.CookbookRepository
import com.neostudios.zest.data.repository.RecipeRepository
import com.neostudios.zest.domain.model.Cookbook
import com.neostudios.zest.domain.model.Recipe
import com.neostudios.zest.ui.screens.CookbooksViewModel
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
class CookbooksViewModelTest {

    private lateinit var viewModel: CookbooksViewModel
    private val cookbookRepository: CookbookRepository = mockk()
    private val recipeRepository: RecipeRepository = mockk()
    private val testDispatcher = UnconfinedTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        coEvery { cookbookRepository.getCookbooks() } returns emptyList()
        coEvery { recipeRepository.getAllRecipes() } returns emptyList()
        viewModel = CookbooksViewModel(cookbookRepository, recipeRepository)
    }

    @Test
    fun `loadCookbooks updates uiState with cookbooks`() = runTest {
        val mockCookbooks = listOf(Cookbook(id = "c1", name = "My Cookbook", description = "My favorite recipes", isPublic = false, recipeIds = emptyList()))
        coEvery { cookbookRepository.getCookbooks() } returns mockCookbooks

        viewModel.loadCookbooks()

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertEquals(mockCookbooks, uiState.cookbooks)
    }

    @Test
    fun `createCookbook reloads cookbooks`() = runTest {
        val newCookbook = Cookbook(name = "New Cookbook", description = "New recipes", isPublic = true, recipeIds = emptyList())
        coEvery { cookbookRepository.createCookbook(any()) } returns Unit
        coEvery { cookbookRepository.getCookbooks() } returns listOf(newCookbook)

        viewModel.createCookbook(newCookbook.name, newCookbook.description, newCookbook.isPublic)

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.cookbooks.contains(newCookbook))
    }

    @Test
    fun `updateCookbook reloads cookbooks`() = runTest {
        val cookbook = Cookbook(id = "c1", name = "My Cookbook", description = "My favorite recipes", isPublic = false, recipeIds = emptyList())
        val updatedCookbook = cookbook.copy(name = "Updated Cookbook")
        coEvery { cookbookRepository.getCookbooks() } returns listOf(cookbook) // Initial load
        coEvery { cookbookRepository.updateCookbook(updatedCookbook) } returns Unit
        coEvery { cookbookRepository.getCookbooks() } returns listOf(updatedCookbook) // After update

        viewModel.loadCookbooks() // Initial load
        viewModel.updateCookbook(updatedCookbook)

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertEquals("Updated Cookbook", uiState.cookbooks.first().name)
    }

    @Test
    fun `deleteCookbook reloads cookbooks`() = runTest {
        val cookbook = Cookbook(id = "c1", name = "My Cookbook", description = "My favorite recipes", isPublic = false, recipeIds = emptyList())
        coEvery { cookbookRepository.getCookbooks() } returns listOf(cookbook) // Initial load
        coEvery { cookbookRepository.deleteCookbook("c1") } returns Unit
        coEvery { cookbookRepository.getCookbooks() } returns emptyList() // After delete

        viewModel.loadCookbooks() // Initial load
        viewModel.deleteCookbook("c1")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.cookbooks.isEmpty())
    }

    @Test
    fun `addRecipeToCookbook reloads cookbooks`() = runTest {
        val cookbook = Cookbook(id = "c1", name = "My Cookbook", description = "My favorite recipes", isPublic = false, recipeIds = emptyList())
        val updatedCookbook = cookbook.copy(recipeIds = listOf("r1"))
        coEvery { cookbookRepository.getCookbooks() } returns listOf(cookbook) // Initial load
        coEvery { cookbookRepository.updateCookbook(updatedCookbook) } returns Unit
        coEvery { cookbookRepository.getCookbooks() } returns listOf(updatedCookbook) // After add

        viewModel.loadCookbooks() // Initial load
        viewModel.addRecipeToCookbook("c1", "r1")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.cookbooks.first().recipeIds.contains("r1"))
    }

    @Test
    fun `removeRecipeFromCookbook reloads cookbooks`() = runTest {
        val cookbook = Cookbook(id = "c1", name = "My Cookbook", description = "My favorite recipes", isPublic = false, recipeIds = listOf("r1"))
        val updatedCookbook = cookbook.copy(recipeIds = emptyList())
        coEvery { cookbookRepository.getCookbooks() } returns listOf(cookbook) // Initial load
        coEvery { cookbookRepository.updateCookbook(updatedCookbook) } returns Unit
        coEvery { cookbookRepository.getCookbooks() } returns listOf(updatedCookbook) // After remove

        viewModel.loadCookbooks() // Initial load
        viewModel.removeRecipeFromCookbook("c1", "r1")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.cookbooks.first().recipeIds.isEmpty())
    }
}
