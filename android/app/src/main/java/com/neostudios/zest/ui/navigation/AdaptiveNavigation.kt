package com.neostudios.zest.ui.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.material3.windowsizeclass.WindowSizeClass
import androidx.compose.material3.windowsizeclass.WindowWidthSizeClass
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.neostudios.zest.ui.screens.*
import kotlinx.coroutines.launch

sealed class Screen(val route: String, val title: String, val icon: Int) {
    object Recipes : Screen("recipes", "Recipes", android.R.drawable.ic_menu_my_calendar)
    object MealPlan : Screen("meal_plan", "Meal Plan", android.R.drawable.ic_menu_today)
    object Shopping : Screen("shopping", "Shopping", android.R.drawable.ic_menu_add)
    object Cookbooks : Screen("cookbooks", "Cookbooks", android.R.drawable.ic_menu_sort_by_size)
    object Nutrition : Screen("nutrition", "Nutrition", android.R.drawable.ic_menu_view)
    object Timers : Screen("timers", "Timers", android.R.drawable.ic_menu_recent_history)
    object AIAssistant : Screen("ai_assistant", "AI Assistant", android.R.drawable.ic_menu_help)
    object Settings : Screen("settings", "Settings", android.R.drawable.ic_menu_preferences)
    object MealKits : Screen("meal_kits", "Meal Kits", android.R.drawable.ic_menu_gallery)
    object CollaborativeMealPlans : Screen("collaborative_meal_plans", "Collab Plans", android.R.drawable.ic_menu_share)
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AdaptiveNavigation(
    windowSizeClass: WindowSizeClass,
    modifier: Modifier = Modifier
) {
    val navController = rememberNavController()
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    val screens = listOf(
        Screen.Recipes,
        Screen.MealPlan,
        Screen.Shopping,
        Screen.Cookbooks,
        Screen.Nutrition,
        Screen.Timers,
        Screen.AIAssistant,
        Screen.Settings,
        Screen.MealKits,
        Screen.CollaborativeMealPlans
    )

    when (windowSizeClass.widthSizeClass) {
        WindowWidthSizeClass.Compact -> {
            // Phone layout with bottom navigation
            CompactLayout(
                navController = navController,
                currentRoute = currentRoute,
                screens = screens,
                modifier = modifier
            )
        }
        WindowWidthSizeClass.Medium, WindowWidthSizeClass.Expanded -> {
            // Tablet layout with navigation rail or drawer
            TabletLayout(
                navController = navController,
                currentRoute = currentRoute,
                screens = screens,
                isExpanded = windowSizeClass.widthSizeClass == WindowWidthSizeClass.Expanded,
                modifier = modifier
            )
        }
    }
}

@Composable
private fun CompactLayout(
    navController: NavHostController,
    currentRoute: String?,
    screens: List<Screen>,
    modifier: Modifier = Modifier
) {
    val drawerState = rememberDrawerState(initialValue = DrawerValue.Closed)
    val scope = rememberCoroutineScope()
    
    ModalNavigationDrawer(
        drawerState = drawerState,
        drawerContent = {
            ModalDrawerSheet {
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Zest",
                    style = MaterialTheme.typography.headlineMedium,
                    modifier = Modifier.padding(horizontal = 28.dp, vertical = 16.dp)
                )
                Divider()
                Spacer(modifier = Modifier.height(8.dp))
                screens.forEach { screen ->
                    NavigationDrawerItem(
                        icon = { Icon(painterResource(screen.icon), contentDescription = null) },
                        label = { Text(screen.title) },
                        selected = currentRoute == screen.route,
                        onClick = {
                            scope.launch { drawerState.close() }
                            navController.navigate(screen.route) {
                                popUpTo(navController.graph.startDestinationId) {
                                    saveState = true
                                }
                                launchSingleTop = true
                                restoreState = true
                            }
                        },
                        modifier = Modifier.padding(horizontal = 12.dp)
                    )
                }
            }
        }
    ) {
        Scaffold(
            topBar = {
                TopAppBar(
                    title = { Text("Zest") },
                    navigationIcon = {
                        IconButton(onClick = { scope.launch { drawerState.open() } }) {
                            Icon(
                                painter = painterResource(android.R.drawable.ic_menu_sort_by_size),
                                contentDescription = "Menu"
                            )
                        }
                    }
                )
            },
            bottomBar = {
                NavigationBar {
                    // Show only main screens in bottom nav
                    val mainScreens = listOf(
                        Screen.Recipes,
                        Screen.MealPlan,
                        Screen.Shopping,
                        Screen.MealKits, // Added MealKits to bottom nav
                        Screen.CollaborativeMealPlans, // Added CollaborativeMealPlans to bottom nav
                        Screen.Settings
                    )
                    mainScreens.forEach { screen ->
                        NavigationBarItem(
                            icon = { Icon(painterResource(screen.icon), contentDescription = screen.title) },
                            label = { Text(screen.title) },
                            selected = currentRoute == screen.route,
                            onClick = {
                                navController.navigate(screen.route) {
                                    popUpTo(navController.graph.startDestinationId) {
                                        saveState = true
                                    }
                                    launchSingleTop = true
                                    restoreState = true
                                }
                            }
                        )
                    }
                }
            },
            modifier = modifier
        ) { paddingValues ->
            NavigationHost(
                navController = navController,
                modifier = Modifier.padding(paddingValues)
            )
        }
    }
}

@Composable
private fun TabletLayout(
    navController: NavHostController,
    currentRoute: String?,
    screens: List<Screen>,
    isExpanded: Boolean,
    modifier: Modifier = Modifier
) {
    // Tablets use ONLY sidebar navigation - NO bottom navigation bar
    Row(modifier = modifier.fillMaxSize()) {
        if (isExpanded) {
            // Permanent navigation drawer for large tablets (landscape, 10"+)
            PermanentNavigationDrawer(
                drawerContent = {
                    PermanentDrawerSheet(modifier = Modifier.width(280.dp)) {
                        Spacer(modifier = Modifier.height(16.dp))
                        Text(
                            text = "Zest",
                            style = MaterialTheme.typography.headlineMedium,
                            color = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.padding(horizontal = 28.dp, vertical = 16.dp)
                        )
                        Divider()
                        Spacer(modifier = Modifier.height(8.dp))
                        
                        // All navigation items visible in sidebar
                        screens.forEach { screen ->
                            NavigationDrawerItem(
                                icon = { Icon(painterResource(screen.icon), contentDescription = null) },
                                label = { Text(screen.title) },
                                selected = currentRoute == screen.route,
                                onClick = {
                                    navController.navigate(screen.route) {
                                        popUpTo(navController.graph.startDestinationId) {
                                            saveState = true
                                        }
                                        launchSingleTop = true
                                        restoreState = true
                                    }
                                },
                                modifier = Modifier.padding(horizontal = 12.dp, vertical = 4.dp)
                            )
                        }
                        
                        Spacer(modifier = Modifier.weight(1f))
                        
                        // User section at bottom
                        Divider()
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(16.dp),
                            verticalAlignment = androidx.compose.ui.Alignment.CenterVertically
                        ) {
                            Surface(
                                modifier = Modifier.size(40.dp),
                                shape = CircleShape,
                                color = MaterialTheme.colorScheme.primary
                            ) {
                                Box(contentAlignment = androidx.compose.ui.Alignment.Center) {
                                    Text(
                                        text = "U",
                                        style = MaterialTheme.typography.titleMedium,
                                        color = MaterialTheme.colorScheme.onPrimary
                                    )
                                }
                            }
                            Spacer(modifier = Modifier.width(12.dp))
                            Column {
                                Text(
                                    text = "User",
                                    style = MaterialTheme.typography.bodyMedium,
                                    fontWeight = androidx.compose.ui.text.font.FontWeight.Medium
                                )
                                Text(
                                    text = "user@example.com",
                                    style = MaterialTheme.typography.bodySmall,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                )
                            }
                        }
                    }
                }
            ) {
                // Content area - full height, no bottom bar
                NavigationHost(
                    navController = navController,
                    modifier = Modifier.fillMaxSize()
                )
            }
        } else {
            // Navigation rail for medium tablets (portrait, 7-10")
            NavigationRail(
                modifier = Modifier.fillMaxHeight()
            ) {
                Spacer(modifier = Modifier.height(16.dp))
                
                // All navigation items in rail
                screens.forEach { screen ->
                    NavigationRailItem(
                        icon = { Icon(painterResource(screen.icon), contentDescription = screen.title) },
                        label = { Text(screen.title, maxLines = 1) },
                        selected = currentRoute == screen.route,
                        onClick = {
                            navController.navigate(screen.route) {
                                popUpTo(navController.graph.startDestinationId) {
                                    saveState = true
                                }
                                launchSingleTop = true
                                restoreState = true
                            }
                        }
                    )
                }
            }
            
            // Content area - full height, no bottom bar
            NavigationHost(
                navController = navController,
                modifier = Modifier.fillMaxSize()
            )
        }
    }
}

@Composable
private fun NavigationHost(
    navController: NavHostController,
    modifier: Modifier = Modifier,
    authViewModel: AuthViewModel = hiltViewModel()
) {
    NavGraph(navController = navController, authViewModel = authViewModel)
}

// Placeholder screens for missing features


