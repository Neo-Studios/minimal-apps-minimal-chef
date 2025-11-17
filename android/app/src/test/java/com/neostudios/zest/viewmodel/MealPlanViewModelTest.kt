package com.neostudios.zest.viewmodel

import com.neostudios.zest.data.repository.MealPlanRepository
import com.neostudios.zest.data.repository.RecipeRepository
import com.neostudios.zest.domain.model.MealPlan
import com.neostudios.zest.domain.model.Recipe
import com.neostudios.zest.ui.screens.MealPlanViewModel
import com.neostudios.zest.ui.screens.MealPlanUiState
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
import java.time.LocalDate
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertNotNull
import kotlin.test.assertTrue

@ExperimentalCoroutinesApi
class MealPlanViewModelTest {

    private lateinit var viewModel: MealPlanViewModel
    private val mealPlanRepository: MealPlanRepository = mockk()
    private val recipeRepository: RecipeRepository = mockk()
    private val testDispatcher = UnconfinedTestDispatcher()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        coEvery { recipeRepository.getAllRecipes() } returns emptyList()
        coEvery { mealPlanRepository.getMealPlansForWeek(any()) } returns emptyMap()
        viewModel = MealPlanViewModel(mealPlanRepository, recipeRepository)
    }

    @Test
    fun `loadMealPlans updates uiState with meal plans and recipes`() = runTest {
        val today = LocalDate.now()
        val mockRecipes = listOf(Recipe(id = "r1", name = "Recipe 1"))
        val mockMealPlans = mapOf(today to MealPlan(date = today, meals = mapOf("breakfast" to listOf("r1"))))

        coEvery { recipeRepository.getAllRecipes() } returns mockRecipes
        coEvery { mealPlanRepository.getMealPlansForWeek(today) } returns mockMealPlans

        viewModel.loadMealPlans(today)

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertEquals(mockMealPlans, uiState.mealPlans)
        assertEquals(mockRecipes, uiState.allRecipes)
        assertEquals(today, uiState.selectedDate)
    }

    @Test
    fun `addRecipeToMealPlan reloads meal plans`() = runTest {
        val today = LocalDate.now()
        coEvery { mealPlanRepository.addRecipeToMealPlan(any(), any(), any()) } returns Unit
        coEvery { mealPlanRepository.getMealPlansForWeek(any()) } returns emptyMap() // Initial load
        coEvery { mealPlanRepository.getMealPlansForWeek(today) } returns mapOf(today to MealPlan(date = today, meals = mapOf("lunch" to listOf("r2")))) // After add

        viewModel.loadMealPlans(today) // Initial load
        viewModel.addRecipeToMealPlan(today, "lunch", "r2")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertNotNull(uiState.mealPlans[today])
        assertTrue(uiState.mealPlans[today]?.meals?.get("lunch")?.contains("r2") == true)
    }

    @Test
    fun `removeRecipeFromMealPlan reloads meal plans`() = runTest {
        val today = LocalDate.now()
        val initialMealPlan = mapOf(today to MealPlan(date = today, meals = mapOf("dinner" to listOf("r3"))))
        val afterRemoveMealPlan = mapOf(today to MealPlan(date = today, meals = emptyMap()))

        coEvery { mealPlanRepository.getMealPlansForWeek(any()) } returns initialMealPlan // Initial load
        coEvery { mealPlanRepository.removeRecipeFromMealPlan(any(), any(), any()) } returns Unit
        coEvery { mealPlanRepository.getMealPlansForWeek(today) } returns afterRemoveMealPlan // After remove

        viewModel.loadMealPlans(today) // Initial load
        viewModel.removeRecipeFromMealPlan(today, "dinner", "r3")

        val uiState = viewModel.uiState.first()
        assertFalse(uiState.isLoading)
        assertTrue(uiState.mealPlans[today]?.meals?.get("dinner")?.isEmpty() == true)
    }

    @Test
    fun `changeSelectedDate updates selected date and reloads meal plans`() = runTest {
        val initialDate = LocalDate.now()
        val nextDay = initialDate.plusDays(1)

        coEvery { mealPlanRepository.getMealPlansForWeek(initialDate) } returns emptyMap()
        coEvery { mealPlanRepository.getMealPlansForWeek(nextDay) } returns emptyMap()

        viewModel.loadMealPlans(initialDate)
        viewModel.changeSelectedDate(1)

        val uiState = viewModel.uiState.first()
        assertEquals(nextDay, uiState.selectedDate)
    }
}
