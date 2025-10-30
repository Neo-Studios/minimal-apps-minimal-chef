import 'package:flutter/material.dart';

class AddShoppingListItemScreen extends StatefulWidget {
  const AddShoppingListItemScreen({super.key});

  @override
  State<AddShoppingListItemScreen> createState() => _AddShoppingListItemScreenState();
}

class _AddShoppingListItemScreenState extends State<AddShoppingListItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_nameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shopping List Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveItem,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
