
import 'package:flutter/material.dart';
import 'package:minimal_chef/services/scraper_service.dart';

class ImportRecipeScreen extends StatefulWidget {
  const ImportRecipeScreen({super.key});

  @override
  State<ImportRecipeScreen> createState() => _ImportRecipeScreenState();
}

class _ImportRecipeScreenState extends State<ImportRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _scraperService = ScraperService();
  bool _isLoading = false;

  void _importRecipe() async {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text;
      setState(() {
        _isLoading = true;
      });
      try {
        final recipe = await _scraperService.scrapeRecipe(url);
        // TODO: Navigate to a new screen to show the scraped recipe
        print('Scraped recipe: ${recipe.name}');
      } catch (e) {
        print('Error scraping recipe: $e');
        // Show an error to the user
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Recipe URL',
                  hintText: 'https://example.com/recipe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  if (!RegExp(r'^https?:\/\/').hasMatch(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _importRecipe,
                      child: const Text('Import'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
