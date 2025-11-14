package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.theme.MinimalChefTheme
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class ShoppingListTest {

    @get:Rule
    val composeTestRule = createComposeRule()

    @Test
    fun shoppingList_addItem_displaysInList() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // ShoppingScreen implementation
            }
        }

        // Type in text field
        composeTestRule
            .onNodeWithTag("addItemField")
            .performTextInput("Tomatoes")

        // Click add button
        composeTestRule
            .onNodeWithTag("addButton")
            .performClick()

        // Verify item appears
        composeTestRule
            .onNodeWithText("Tomatoes")
            .assertExists()
    }

    @Test
    fun shoppingList_checkItem_marksAsComplete() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // ShoppingScreen with items
            }
        }

        // Click checkbox
        composeTestRule
            .onAllNodesWithTag("itemCheckbox")
            .onFirst()
            .performClick()

        // Verify item is checked
        // This would require checking the state
    }

    @Test
    fun shoppingList_deleteItem_removesFromList() {
        composeTestRule.setContent {
            MinimalChefTheme {
                // ShoppingScreen with items
            }
        }

        // Swipe to delete or click delete button
        composeTestRule
            .onAllNodesWithTag("deleteButton")
            .onFirst()
            .performClick()

        // Verify item is removed
        // This would require checking the list count
    }
}
