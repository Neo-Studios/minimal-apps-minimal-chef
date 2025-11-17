package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.screens.CookbooksScreen
import com.neostudios.zest.ui.theme.MinimalChefTheme
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@HiltAndroidTest
@RunWith(AndroidJUnit4::class)
class CookbooksScreenTest {

    @get:Rule(order = 0)
    val hiltRule = HiltAndroidRule(this)

    @get:Rule(order = 1)
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Before
    fun setup() {
        hiltRule.inject()
        composeTestRule.setContent {
            MinimalChefTheme {
                CookbooksScreen()
            }
        }
    }

    @Test
    fun cookbooksScreen_displaysEmptyMessage() {
        composeTestRule.onNodeWithText("No cookbooks yet! Create one to get started.").assertIsDisplayed()
    }

    @Test
    fun cookbooksScreen_createCookbookButton_opensDialog() {
        composeTestRule.onNodeWithContentDescription("Create Cookbook").performClick()
        composeTestRule.onNodeWithText("Create New Cookbook").assertIsDisplayed()
    }

    @Test
    fun cookbooksScreen_createCookbookDialog_createsCookbook() {
        composeTestRule.onNodeWithContentDescription("Create Cookbook").performClick()
        composeTestRule.onNodeWithText("Create New Cookbook").assertIsDisplayed()

        composeTestRule.onNodeWithLabel("Cookbook Name").performTextInput("My New Cookbook")
        composeTestRule.onNodeWithLabel("Description (Optional)").performTextInput("A collection of my favorite recipes")

        composeTestRule.onNodeWithText("Create").performClick()

        composeTestRule.onNodeWithText("My New Cookbook").assertIsDisplayed()
        composeTestRule.onNodeWithText("A collection of my favorite recipes").assertIsDisplayed()
    }
}
