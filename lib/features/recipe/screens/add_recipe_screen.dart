
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/recipe/models/recipe.dart';
import 'package:minimal_chef/features/recipe/services/recipe_service.dart';
import 'package:minimal_chef/core/services/storage_service.dart';

class AddRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddRecipeScreen({super.key, this.recipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final RecipeService _recipeService = RecipeService();
  final StorageService _storageService = StorageService();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;
  XFile? _image;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.recipe?.name);
    _descriptionController =
        TextEditingController(text: widget.recipe?.description);
    _ingredientsController = TextEditingController(
        text: widget.recipe?.ingredients.map((i) => i.name).join('\n'));
    _instructionsController =
        TextEditingController(text: widget.recipe?.instructions.join('\n'));
    _imageUrl = widget.recipe?.imageUrl;
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      // 1. Upload image if a new one is selected
      if (_image != null) {
        _imageUrl = await _storageService.uploadImage(_image!);
      }

      // 2. Create Recipe object
      final recipe = Recipe(
        id: widget.recipe?.id,
        name: _nameController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrl ?? '',
        instructions: _instructionsController.text
            .split('\n')
            .where((s) => s.trim().isNotEmpty)
            .toList(),
        ingredients: _ingredientsController.text
            .split('\n')
            .where((s) => s.trim().isNotEmpty)
            .map((name) => Ingredient(name: name))
            .toList(),
      );

      // 3. Save to Firestore
      if (widget.recipe == null) {
        await _recipeService.addRecipe(recipe);
      } else {
        await _recipeService.updateRecipe(recipe);
      }

      // 4. Go back
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipe == null ? 'New Recipe' : 'Edit Recipe',
          style: theme.textTheme.headlineMedium,
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _image != null
                        ? Image.file(File(_image!.path), fit: BoxFit.cover)
                        : (_imageUrl != null && _imageUrl!.isNotEmpty)
                            ? Image.network(_imageUrl!, fit: BoxFit.cover)
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 48,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('Add a photo'),
                                  ],
                                ),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(_nameController, 'Recipe Name', theme),
              const SizedBox(height: 24),
              _buildTextField(_descriptionController, 'Description', theme,
                  maxLines: 3),
              const SizedBox(height: 24),
              _buildTextField(
                  _ingredientsController, 'Ingredients (one per line)', theme,
                  maxLines: 5),
              const SizedBox(height: 24),
              _buildTextField(
                  _instructionsController, 'Instructions (one per line)', theme,
                  maxLines: 8),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveRecipe,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Save Recipe',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, ThemeData theme,
      {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        maxLines: maxLines,
        validator: (value) =>
            value!.isEmpty ? 'Please enter a ${label.toLowerCase()}' : null,
      ),
    );
  }
}
