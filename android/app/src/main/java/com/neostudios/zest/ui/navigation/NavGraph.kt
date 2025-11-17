package com.neostudios.zest.ui.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.neostudios.zest.ui.screens.*

sealed class Screen(val route: String) {
    object Login : Screen("login")
    object Recipes : Screen("recipes")
    object MealPlan : Screen("meal_plan")
    object Shopping : Screen("shopping")
    object Cookbooks : Screen("cookbooks")
    object Nutrition : Screen("nutrition")
    object Timers : Screen("timers")
    object AIAssistant : Screen("ai_assistant")
    object Settings : Screen("settings")
    object MealKits : Screen("meal_kits")
    object CollaborativeMealPlans : Screen("collaborative_meal_plans")
    object RecipeDetail : Screen("recipe/{recipeId}") {
        fun createRoute(recipeId: String) = "recipe/$recipeId"
    }
    object MealKitDetail : Screen("meal_kit/{mealKitId}") {
        fun createRoute(mealKitId: String) = "meal_kit/$mealKitId"
    }
    object CollaborativeMealPlanDetail : Screen("collaborative_meal_plan/{planId}") {
        fun createRoute(planId: String) = "collaborative_meal_plan/$planId"
    }
    object CookingMode : Screen("cooking_mode/{recipeId}") {
        fun createRoute(recipeId: String) = "cooking_mode/$recipeId"
    }
    object ARCooking : Screen("ar_cooking/{recipeId}") {
        fun createRoute(recipeId: String) = "ar_cooking/$recipeId"
    }
}

@Composable
fun NavGraph(navController: NavHostController, authViewModel: AuthViewModel = hiltViewModel()) {
    val currentUser by authViewModel.currentUser.collectAsState()

    val startDestination = if (currentUser != null) Screen.Recipes.route else Screen.Login.route

    NavHost(navController = navController, startDestination = startDestination) {
        composable(Screen.Login.route) {
            LoginScreen(onAuthSuccess = {
                navController.navigate(Screen.Recipes.route) {
                    popUpTo(Screen.Login.route) { inclusive = true }
                }
            })
        }
        composable(Screen.Recipes.route) { RecipesScreen(navController) }
        composable(Screen.MealPlan.route) { MealPlanScreen() }
        composable(Screen.Shopping.route) { ShoppingListScreen() }
        composable(Screen.Cookbooks.route) { CookbooksScreen() }
        composable(Screen.Nutrition.route) { NutritionDashboardScreen() }
        composable(Screen.Timers.route) { TimersScreen() }
        composable(Screen.AIAssistant.route) { AIAssistantScreen() }
        composable(Screen.Settings.route) { SettingsScreen() }
        composable(Screen.MealKits.route) { MealKitsScreen(navController) }
        composable(Screen.CollaborativeMealPlans.route) { CollaborativeMealPlansScreen(navController) }
        composable(
            route = Screen.RecipeDetail.route,
            arguments = listOf(navArgument("recipeId") { type = NavType.StringType })
        ) { backStackEntry ->
            val recipeId = backStackEntry.arguments?.getString("recipeId")
            if (recipeId != null) {
                RecipeDetailScreen(recipeId = recipeId, navController = navController)
            }
        }
        composable(
            route = Screen.MealKitDetail.route,
            arguments = listOf(navArgument("mealKitId") { type = NavType.StringType })
        ) { backStackEntry ->
            val mealKitId = backStackEntry.arguments?.getString("mealKitId")
            if (mealKitId != null) {
                MealKitDetailScreen(mealKitId = mealKitId, navController = navController)
            }
        }
        composable(
            route = Screen.CollaborativeMealPlanDetail.route,
            arguments = listOf(navArgument("planId") { type = NavType.StringType })
        ) { backStackEntry ->
            val planId = backStackEntry.arguments?.getString("planId")
            if (planId != null) {
                CollaborativeMealPlanDetailScreen(planId = planId, navController = navController)
            }
        }
        composable(
            route = Screen.CookingMode.route,
            arguments = listOf(navArgument("recipeId") { type = NavType.StringType })
        ) { backStackEntry ->
            val recipeId = backStackEntry.arguments?.getString("recipeId")
            if (recipeId != null) {
                CookingModeScreen(recipeId = recipeId, navController = navController)
            }
        }
        composable(
            route = Screen.ARCooking.route,
            arguments = listOf(navArgument("recipeId") { type = NavType.StringType })
        ) { backStackEntry ->
            val recipeId = backStackEntry.arguments?.getString("recipeId")
            if (recipeId != null) {
                ARCookingScreen(recipeId = recipeId, navController = navController)
            }
        }
    }
}
