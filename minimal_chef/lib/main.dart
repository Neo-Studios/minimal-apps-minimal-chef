import 'package:flutter/material.dart';
import 'package:minimal_chef/screens/discover_screen.dart';
import 'package:minimal_chef/screens/meal_plan_screen.dart';
import 'package:minimal_chef/screens/recipes_screen.dart';
import 'package:minimal_chef/screens/shopping_list_screen.dart';

void main() {
  runApp(const MinimalChefApp());
}

class MinimalChefApp extends StatelessWidget {
  const MinimalChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Chef',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA500),
          brightness: Brightness.light,
          primary: const Color(0xFFFFA500),
          secondary: const Color(0xFF00B4D8),
          background: const Color(0xFFFFF8E1),
          onBackground: const Color(0xFF2F2F2F),
          surface: const Color(0xFFFFF8E1),
          onSurface: const Color(0xFF2F2F2F),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Times New Roman'),
          displayMedium: TextStyle(fontFamily: 'Times New Roman'),
          displaySmall: TextStyle(fontFamily: 'Times New Roman'),
          headlineLarge: TextStyle(fontFamily: 'Times New Roman'),
          headlineMedium: TextStyle(fontFamily: 'Times New Roman'),
          headlineSmall: TextStyle(fontFamily: 'Times New Roman'),
          titleLarge: TextStyle(fontFamily: 'Times New Roman'),
          titleMedium: TextStyle(fontFamily: 'Times New Roman'),
          titleSmall: TextStyle(fontFamily: 'Times New Roman'),
          bodyLarge: TextStyle(fontFamily: 'Noto Sans'),
          bodyMedium: TextStyle(fontFamily: 'Noto Sans'),
          bodySmall: TextStyle(fontFamily: 'Noto Sans'),
          labelLarge: TextStyle(fontFamily: 'Noto Sans'),
          labelMedium: TextStyle(fontFamily: 'Noto Sans'),
          labelSmall: TextStyle(fontFamily: 'Noto Sans'),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA500),
          brightness: Brightness.dark,
          primary: const Color(0xFFFFA500),
          secondary: const Color(0xFF00B4D8),
          background: const Color(0xFF2F2F2F),
          onBackground: const Color(0xFFFFF8E1),
          surface: const Color(0xFF2F2F2F),
          onSurface: const Color(0xFFFFF8E1),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          displayMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          displaySmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineSmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleSmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          bodyLarge: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          bodyMedium: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          bodySmall: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelLarge: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelMedium: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelSmall: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
        ),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 600;
    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
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
                  icon: Icon(Icons.book_outlined),
                  selectedIcon: Icon(Icons.book),
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
            const VerticalDivider(thickness: 1, width: 1),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
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
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}
