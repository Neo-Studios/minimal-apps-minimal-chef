package com.neostudios.zest.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.neostudios.zest.ui.screens.* 

sealed class Screen(val route: String) {
    object Recipes : Screen("recipes")
    object MealPlan : Screen("meal_plan")
    object Shopping : Screen("shopping")
    object Settings : Screen("settings")
    object RecipeDetail : Screen("recipe/{recipeId}") {
        fun createRoute(recipeId: String) = "recipe/$recipeId"
    }
}

@Composable
fun NavGraph(navController: NavHostController) {
    NavHost(navController = navController, startDestination = Screen.Recipes.route) {
        composable(Screen.Recipes.route) { RecipesScreen(navController) }
        composable(Screen.MealPlan.route) { MealPlanScreen() }
        composable(Screen.Shopping.route) { ShoppingScreen() }
        composable(Screen.Settings.route) { SettingsScreen() }
        composable(
            route = Screen.RecipeDetail.route,
            arguments = listOf(navArgument("recipeId") { type = NavType.StringType })
        ) { backStackEntry ->
            val recipeId = backStackEntry.arguments?.getString("recipeId")
            // In a real app, you'd use the recipeId to fetch the recipe from a repository
            // For now, we'll just pass the ID to the screen
            if (recipeId != null) {
                RecipeDetailScreen(recipeId = recipeId, navController = navController)
            }
        }
    }
}
