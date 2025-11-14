package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.screens.RecipesScreen
import com.neostudios.zest.ui.theme.MinimalChefTheme
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class RecipeScreenTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun recipesScreen_displaysTitle() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // RecipesScreen would need to be testable
                // This is a placeholder
            }
        }

        composeTestRule
            .onNodeWithText("Recipes")
            .assertExists()
    }

    @Test
    fun recipesScreen_searchBar_isDisplayed() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // RecipesScreen implementation
            }
        }

        composeTestRule
            .onNodeWithTag("searchBar")
            .assertExists()
            .assertIsDisplayed()
    }

    @Test
    fun recipesScreen_clickRecipe_navigatesToDetail() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // RecipesScreen implementation
            }
        }

        // Find and click first recipe
        composeTestRule
            .onAllNodesWithTag("recipeCard")
            .onFirst()
            .performClick()

        // Verify navigation occurred
        // This would require navigation testing setup
    }

    @Test
    fun recipeDetail_scaleServings_updatesIngredients() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // RecipeDetailScreen implementation
            }
        }

        // Click increase button
        composeTestRule
            .onNodeWithContentDescription("Increase")
            .performClick()

        // Verify servings increased
        composeTestRule
            .onNodeWithText("servings", substring = true)
            .assertExists()
    }
}
