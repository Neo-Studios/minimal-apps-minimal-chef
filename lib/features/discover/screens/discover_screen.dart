import 'package:flutter/material.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/screens/recipe_detail_screen.dart';
import 'package:minimal_chef/features/recipe/services/recipe_api_service.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final RecipeApiService _recipeApiService = RecipeApiService();
  Future<Recipe>? _randomRecipeFuture;
  List<Recipe> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRandomRecipe();
  }

  void _fetchRandomRecipe() {
    setState(() {
      _randomRecipeFuture = _recipeApiService.getRandomRecipe();
    });
  }

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _recipeApiService.searchRecipes(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, maybe show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: theme.colorScheme.surface.withAlpha(220),
            title: _buildSearchField(theme),
          ),
          _searchController.text.isEmpty
              ? _buildRandomRecipeSection(theme)
              : _buildSearchResults(theme),
        ],
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: const InputDecoration(
          hintText: 'Search for a recipe...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildRandomRecipeSection(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Don't know what to cook?", style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text("Here's a random recipe for you:", style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),
            FutureBuilder<Recipe>(
              future: _randomRecipeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        const Text('Could not fetch recipe.'),
                        TextButton(onPressed: _fetchRandomRecipe, child: const Text('Try Again')),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No recipe found.'));
                }

                final recipe = snapshot.data!;
                return RecipeCard(recipe: recipe, theme: theme);
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _fetchRandomRecipe,
                icon: const Icon(Icons.refresh),
                label: const Text('Another One!'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    if (_isLoading) {
      return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    }

    if (_searchResults.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Center(child: Text('No recipes found.')),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(24.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final recipe = _searchResults[index];
            return RecipeCard(recipe: recipe, theme: theme);
          },
          childCount: _searchResults.length,
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.theme,
  });

  final Recipe recipe;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(recipe: recipe),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: theme.colorScheme.surfaceContainerHighest,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withValues(alpha: 0.2),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.0)],
                  ),
                ),
                child: Text(
                  recipe.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
