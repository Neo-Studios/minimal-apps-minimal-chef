
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimal_chef/models/ingredient.dart';
import 'package:minimal_chef/models/recipe.dart';
import 'package:minimal_chef/services/recipe_service.dart';
import 'package:minimal_chef/services/storage_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Add Recipe' : 'Edit Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveRecipe,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: _image != null
                      ? Image.file(File(_image!.path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover)
                      : (_imageUrl != null && _imageUrl!.isNotEmpty)
                          ? Image.network(_imageUrl!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover)
                          : Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Text('Tap to select an image'),
                              ),
                            ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Recipe Name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(
                      labelText: 'Ingredients (one per line)'),
                  maxLines: 5,
                ),
                TextFormField(
                  controller: _instructionsController,
                  decoration: const InputDecoration(
                      labelText: 'Instructions (one per line)'),
                  maxLines: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
