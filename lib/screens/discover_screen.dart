import 'package:flutter/material.dart';
import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/screens/add_recipe_screen.dart';
import 'package:minimal_chef/screens/add_shopping_list_item_screen.dart';
import 'package:minimal_chef/screens/recipe_detail_screen.dart';
import 'package:minimal_chef/services/recipe_service.dart';
import 'package:minimal_chef/services/search_service.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<Recipe>> _recipes;
  List<Recipe> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _recipes = _recipeService.getRecipes();
    SearchService.init();
  }

  void _onSearchChanged(String query) {
    final results = SearchService.search(query);
    setState(() {
      _searchResults = results;
    });
  }

  void _showFabMenu() {
    final RenderBox renderBox = _fabKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy - size.height - 110,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        const PopupMenuItem(
          value: 'add_recipe',
          child: ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('New Recipe'),
          ),
        ),
        const PopupMenuItem(
          value: 'add_shopping_item',
          child: ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('New Shopping List Item'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'add_recipe') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
        );
      } else if (value == 'add_shopping_item') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddShoppingListItemScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? FutureBuilder<List<Recipe>>(
                    future: _recipes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final recipe = snapshot.data![index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(recipe: recipe),
                                ),
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Image.network(recipe.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(recipe.name, style: Theme.of(context).textTheme.titleMedium),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final recipe = _searchResults[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              Image.network(recipe.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(recipe.name, style: Theme.of(context).textTheme.titleMedium),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        onPressed: _showFabMenu,
        child: const Icon(Icons.add),
      ),
    );
  }
}
