package com.neostudios.zest

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.runtime.*
import androidx.compose.material3.windowsizeclass.ExperimentalMaterial3WindowSizeClassApi
import androidx.compose.material3.windowsizeclass.calculateWindowSizeClass
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.neostudios.zest.ui.navigation.AdaptiveNavigation
import com.neostudios.zest.ui.screens.AppTourScreen
import com.neostudios.zest.ui.screens.AuthViewModel
import com.neostudios.zest.ui.screens.FeatureShowcaseScreen
import com.neostudios.zest.ui.theme.Material3ExpressiveTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalMaterial3WindowSizeClassApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val windowSizeClass = calculateWindowSizeClass(this)
            val authViewModel: AuthViewModel = hiltViewModel()
            val showOnboarding by authViewModel.showOnboarding.collectAsStateWithLifecycle()
            val currentUser by authViewModel.currentUser.collectAsStateWithLifecycle()

            var showAppTour by remember { mutableStateOf(false) }

            Material3ExpressiveTheme {
                if (currentUser != null && showOnboarding) {
                    if (showAppTour) {
                        AppTourScreen(
                            onSkip = {
                                currentUser?.uid?.let { authViewModel.completeOnboarding(it) }
                                showAppTour = false
                            },
                            onComplete = {
                                currentUser?.uid?.let { authViewModel.completeOnboarding(it) }
                                showAppTour = false
                            }
                        )
                    } else {
                        FeatureShowcaseScreen(
                            onSkip = {
                                currentUser?.uid?.let { authViewModel.completeOnboarding(it) }
                                showAppTour = false
                            },
                            onComplete = { showAppTour = true }
                        )
                    }
                } else {
                    AdaptiveNavigation(windowSizeClass = windowSizeClass)
                }
            }
        }
    }
}
