package com.neostudios.zest

import androidx.compose.ui.test.*
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.neostudios.zest.ui.screens.LoginScreen
import com.neostudios.zest.ui.theme.MinimalChefTheme
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@HiltAndroidTest
@RunWith(AndroidJUnit4::class)
class LoginScreenTest {

    @get:Rule(order = 0)
    val hiltRule = HiltAndroidRule(this)

    @get:Rule(order = 1)
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Before
    fun setup() {
        hiltRule.inject()
        composeTestRule.setContent {
            MinimalChefTheme {
                LoginScreen(onAuthSuccess = {})
            }
        }
    }

    @Test
    fun loginScreen_displaysWelcomeMessage() {
        composeTestRule.onNodeWithText("Welcome to Zest!").assertIsDisplayed()
    }

    @Test
    fun loginScreen_googleSignInButton_isDisplayed() {
        composeTestRule.onNodeWithText("Sign in with Google").assertIsDisplayed()
    }
}
