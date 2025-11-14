package com.neostudios.zest.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.neostudios.zest.ui.utils.WindowSizeClass
import com.neostudios.zest.ui.utils.rememberWindowSizeClass

@Composable
fun AdaptiveLayout(
    listContent: @Composable () -> Unit,
    detailContent: @Composable () -> Unit,
    showDetail: Boolean = false
) {
    val windowSizeClass = rememberWindowSizeClass()
    
    when (windowSizeClass) {
        WindowSizeClass.COMPACT -> {
            // Single pane - show either list or detail
            if (showDetail) {
                detailContent()
            } else {
                listContent()
            }
        }
        WindowSizeClass.MEDIUM -> {
            // Two pane side by side
            Row(modifier = Modifier.fillMaxSize()) {
                Box(
                    modifier = Modifier
                        .weight(0.4f)
                        .fillMaxHeight()
                ) {
                    listContent()
                }
                Box(
                    modifier = Modifier
                        .weight(0.6f)
                        .fillMaxHeight()
                ) {
                    detailContent()
                }
            }
        }
        WindowSizeClass.EXPANDED -> {
            // Three pane or wide two pane
            Row(modifier = Modifier.fillMaxSize()) {
                Box(
                    modifier = Modifier
                        .width(400.dp)
                        .fillMaxHeight()
                ) {
                    listContent()
                }
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .fillMaxHeight()
                ) {
                    detailContent()
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AdaptiveNavigationBar(
    selectedIndex: Int,
    onItemSelected: (Int) -> Unit,
    items: List<NavigationItem>
) {
    val windowSizeClass = rememberWindowSizeClass()
    
    when (windowSizeClass) {
        WindowSizeClass.COMPACT -> {
            // Bottom navigation bar
            NavigationBar {
                items.forEachIndexed { index, item ->
                    NavigationBarItem(
                        selected = selectedIndex == index,
                        onClick = { onItemSelected(index) },
                        icon = { Icon(item.icon, contentDescription = item.label) },
                        label = { Text(item.label) }
                    )
                }
            }
        }
        WindowSizeClass.MEDIUM -> {
            // Navigation rail
            NavigationRail {
                items.forEachIndexed { index, item ->
                    NavigationRailItem(
                        selected = selectedIndex == index,
                        onClick = { onItemSelected(index) },
                        icon = { Icon(item.icon, contentDescription = item.label) },
                        label = { Text(item.label) }
                    )
                }
            }
        }
        WindowSizeClass.EXPANDED -> {
            // Navigation drawer
            PermanentNavigationDrawer(
                drawerContent = {
                    PermanentDrawerSheet(modifier = Modifier.width(280.dp)) {
                        Spacer(modifier = Modifier.height(12.dp))
                        items.forEachIndexed { index, item ->
                            NavigationDrawerItem(
                                selected = selectedIndex == index,
                                onClick = { onItemSelected(index) },
                                icon = { Icon(item.icon, contentDescription = item.label) },
                                label = { Text(item.label) },
                                modifier = Modifier.padding(horizontal = 12.dp)
                            )
                        }
                    }
                }
            ) {
                // Content goes here
            }
        }
    }
}

data class NavigationItem(
    val icon: androidx.compose.ui.graphics.vector.ImageVector,
    val label: String,
    val route: String
)
