package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.screens.ShoppingListScreen
import com.neostudios.zest.ui.theme.MinimalChefTheme
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@HiltAndroidTest
@RunWith(AndroidJUnit4::class)
class ShoppingListScreenTest {

    @get:Rule(order = 0)
    val hiltRule = HiltAndroidRule(this)

    @get:Rule(order = 1)
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Before
    fun setup() {
        hiltRule.inject()
        composeTestRule.setContent {
            MinimalChefTheme {
                ShoppingListScreen()
            }
        }
    }

    @Test
    fun shoppingListScreen_displaysEmptyMessage() {
        composeTestRule.onNodeWithText("Your shopping list is empty!").assertIsDisplayed()
    }

    @Test
    fun shoppingListScreen_addItemButton_opensDialog() {
        composeTestRule.onNodeWithContentDescription("Add Item").performClick()
        composeTestRule.onNodeWithText("Add New Item").assertIsDisplayed()
    }

    @Test
    fun shoppingListScreen_addItemDialog_addsItem() {
        composeTestRule.onNodeWithContentDescription("Add Item").performClick()
        composeTestRule.onNodeWithText("Add New Item").assertIsDisplayed()

        composeTestRule.onNodeWithLabel("Item Name").performTextInput("Milk")
        composeTestRule.onNodeWithLabel("Quantity (e.g., 2 lbs, 1 dozen)").performTextInput("1 gallon")
        composeTestRule.onNodeWithLabel("Category (Optional)").performTextInput("Dairy")

        composeTestRule.onNodeWithText("Add").performClick()

        composeTestRule.onNodeWithText("Milk").assertIsDisplayed()
        composeTestRule.onNodeWithText("1 gallon").assertIsDisplayed()
        composeTestRule.onNodeWithText("Dairy").assertIsDisplayed()
    }
}
