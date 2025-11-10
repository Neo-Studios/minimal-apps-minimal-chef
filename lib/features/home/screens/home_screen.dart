import 'package:flutter/material.dart';
import 'package:minimal_chef/features/recipe/screens/add_recipe_screen.dart';
import 'package:minimal_chef/features/discover/screens/discover_screen.dart';
import 'package:minimal_chef/features/meal_plan/screens/meal_plan_screen.dart';
import 'package:minimal_chef/features/recipe/screens/recipes_screen.dart';
import 'package:minimal_chef/features/settings/screens/settings_screen.dart';
import 'package:minimal_chef/features/shopping_list/screens/shopping_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSidebarVisible = true;

  void _navigateToAddRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
    );
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;
    final theme = Theme.of(context);

    final screens = [
      const DiscoverScreen(),
      const RecipesScreen(),
      const MealPlanScreen(),
      const ShoppingListScreen(),
    ];

    final labels = ['Discover', 'Recipes', 'Meal Plan', 'Shopping List'];

    return Scaffold(
      appBar: AppBar(
        leading: isDesktop
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _isSidebarVisible = !_isSidebarVisible;
                  });
                },
              )
            : null,
        title: Text(labels[_selectedIndex], style: theme.textTheme.headlineMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _navigateToSettings,
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: isDesktop
          ? Row(
              children: [
                if (_isSidebarVisible)
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.explore_outlined),
                        selectedIcon: Icon(Icons.explore),
                        label: Text('Discover'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.receipt_long_outlined),
                        selectedIcon: Icon(Icons.receipt_long),
                        label: Text('Recipes'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.calendar_today_outlined),
                        selectedIcon: Icon(Icons.calendar_today),
                        label: Text('Meal Plan'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shopping_cart_outlined),
                        selectedIcon: Icon(Icons.shopping_cart),
                        label: Text('Shopping List'),
                      ),
                    ],
                  ),
                if (_isSidebarVisible) const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: screens[_selectedIndex]),
              ],
            )
          : screens[_selectedIndex],
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Icon(Icons.explore),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long),
                  label: 'Recipes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_today),
                  label: 'Meal Plan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  activeIcon: Icon(Icons.shopping_cart),
                  label: 'Shopping List',
                ),
              ],
            ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton.extended(
              onPressed: _navigateToAddRecipe,
              label: const Text('New Recipe'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }
}
