package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.screens.MealPlanScreen
import com.neostudios.zest.ui.theme.MinimalChefTheme
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@HiltAndroidTest
@RunWith(AndroidJUnit4::class)
class MealPlanScreenTest {

    @get:Rule(order = 0)
    val hiltRule = HiltAndroidRule(this)

    @get:Rule(order = 1)
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Before
    fun setup() {
        hiltRule.inject()
        composeTestRule.setContent {
            MinimalChefTheme {
                MealPlanScreen()
            }
        }
    }

    @Test
    fun mealPlanScreen_displaysDateNavigator() {
        composeTestRule.onNodeWithText("Today").assertIsDisplayed()
        composeTestRule.onNodeWithContentDescription("Previous Day").assertIsDisplayed()
        composeTestRule.onNodeWithContentDescription("Next Day").assertIsDisplayed()
    }

    @Test
    fun mealPlanScreen_displaysMealSections() {
        composeTestRule.onNodeWithText("Breakfast").assertIsDisplayed()
        composeTestRule.onNodeWithText("Lunch").assertIsDisplayed()
        composeTestRule.onNodeWithText("Dinner").assertIsDisplayed()
        composeTestRule.onNodeWithText("Snacks").assertIsDisplayed()
    }

    @Test
    fun mealPlanScreen_addRecipeButton_opensDialog() {
        composeTestRule.onAllNodesWithContentDescription("Add Recipe to Breakfast").onFirst().performClick()
        composeTestRule.onNodeWithText("Select a Recipe").assertIsDisplayed()
    }
}
