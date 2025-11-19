package com.neostudios.zest.ui.screens

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.ArrowForward
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch

data class Feature(
    val title: String,
    val description: String,
    val icon: String // Using string for icon name, you might map this to actual Drawables
)

val features = listOf(
    Feature(
        title = "Welcome to Zest!",
        description = "Your ultimate cooking companion. Let\'s explore some key features.",
        icon = "🍳" // Placeholder icon
    ),
    Feature(
        title = "Recipe Management",
        description = "Organize, discover, and create your favorite recipes with ease.",
        icon = "📚" // Placeholder icon
    ),
    Feature(
        title = "Meal Planning",
        description = "Plan your meals for the week and generate smart shopping lists.",
        icon = "🗓️" // Placeholder icon
    ),
    Feature(
        title = "AI Assistant",
        description = "Get AI-powered recipe suggestions and cooking assistance.",
        icon = "🤖" // Placeholder icon
    ),
)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun FeatureShowcaseScreen(
    onSkip: () -> Unit,
    onComplete: () -> Unit
) {
    val pagerState = rememberPagerState(pageCount = { features.size })
    val coroutineScope = rememberCoroutineScope()
    val currentFeature = features[pagerState.currentPage]
    val isLastFeature = pagerState.currentPage == features.size - 1

    Scaffold(
        modifier = Modifier.fillMaxSize(),
        bottomBar = {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                TextButton(onClick = onSkip) {
                    Text("Skip")
                }
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    Button(
                        onClick = {
                            coroutineScope.launch {
                                pagerState.animateScrollToPage(pagerState.currentPage - 1)
                            }
                        },
                        enabled = pagerState.currentPage > 0,
                        colors = ButtonDefaults.outlinedButtonColors()
                    ) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Previous")
                    }
                    Button(
                        onClick = {
                            if (isLastFeature) {
                                onComplete()
                            } else {
                                coroutineScope.launch {
                                    pagerState.animateScrollToPage(pagerState.currentPage + 1)
                                }
                            }
                        }
                    ) {
                        Text(if (isLastFeature) "Get Started" else "Next")
                        Icon(Icons.Default.ArrowForward, contentDescription = "Next")
                    }
                }
            }
        }
    ) { paddingValues ->
        HorizontalPager(
            state = pagerState,
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) { page ->
            val feature = features[page]
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                Text(
                    text = feature.icon, // Using emoji as placeholder icon
                    style = MaterialTheme.typography.displayLarge,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                Text(
                    text = feature.title,
                    style = MaterialTheme.typography.headlineMedium,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(top = 16.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = feature.description,
                    style = MaterialTheme.typography.bodyLarge,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(horizontal = 16.dp)
                )
            }
        }
    }
}
