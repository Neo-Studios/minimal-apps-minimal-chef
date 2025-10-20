import 'package:flutter/material.dart';
import 'package:minimal_chef/screens/add_recipe_screen.dart';
import 'package:minimal_chef/screens/discover_screen.dart';
import 'package:minimal_chef/screens/meal_plan_screen.dart';
import 'package:minimal_chef/screens/recipes_screen.dart';
import 'package:minimal_chef/screens/settings_screen.dart';
import 'package:minimal_chef/screens/shopping_list_screen.dart';

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
    if (isDesktop) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              setState(() {
                _isSidebarVisible = !_isSidebarVisible;
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _navigateToSettings,
            ),
          ],
        ),
        body: Row(
          children: [
            if (_isSidebarVisible)
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: SizedBox.shrink(),
                    label: Text('Discover'),
                  ),
                  NavigationRailDestination(
                    icon: SizedBox.shrink(),
                    label: Text('Recipes'),
                  ),
                  NavigationRailDestination(
                    icon: SizedBox.shrink(),
                    label: Text('Meal Plan'),
                  ),
                  NavigationRailDestination(
                    icon: SizedBox.shrink(),
                    label: Text('Shopping List'),
                  ),
                ],
              ),
            if (_isSidebarVisible) const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  DiscoverScreen(),
                  RecipesScreen(),
                  MealPlanScreen(),
                  ShoppingListScreen(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: _navigateToAddRecipe,
              child: const Text('New Recipe'),
            ),
            const PopupMenuItem(
              child: Text('New shopping list item'),
            ),
          ],
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _navigateToSettings,
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            DiscoverScreen(),
            RecipesScreen(),
            MealPlanScreen(),
            ShoppingListScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'Meal Plan',
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(),
              label: 'Shopping List',
            ),
          ],
        ),
        floatingActionButton: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: _navigateToAddRecipe,
              child: const Text('New Recipe'),
            ),
            const PopupMenuItem(
              child: Text('New shopping list item'),
            ),
          ],
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}
