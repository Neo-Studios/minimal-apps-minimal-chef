import 'package:flutter/material.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<Ingredient> _items = [];
  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );
  final TextEditingController _manualAddController = TextEditingController();

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020), 
      lastDate: DateTime(2030),
      initialDateRange: _dateRange,
    );
    if (picked != null && picked != _dateRange) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _showManualAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: TextField(
            controller: _manualAddController,
            decoration: const InputDecoration(hintText: 'Enter item name'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (_manualAddController.text.isNotEmpty) {
                  setState(() {
                    _items.add(Ingredient(name: _manualAddController.text, quantity: ''));
                  });
                  _manualAddController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          _buildDateRangeSelector(theme),
          Expanded(
            child: _items.isEmpty
                ? _buildEmptyState(theme)
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return IngredientTile(item: item);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showManualAddDialog,
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildDateRangeSelector(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_dateRange.start.toLocal().toString().split(' ')[0]} - ${_dateRange.end.toLocal().toString().split(' ')[0]}',
              style: theme.textTheme.titleMedium,
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_outlined, color: theme.colorScheme.primary),
              onPressed: _selectDateRange,
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: 20),
          Text('Your shopping list is empty!', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text('Plan some meals to see ingredients here.'),
        ],
      ),
    );
  }
}

class IngredientTile extends StatefulWidget {
  final Ingredient item;

  const IngredientTile({super.key, required this.item});

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
          activeColor: theme.colorScheme.primary,
        ),
        title: Text(
          widget.item.name,
          style: TextStyle(
            decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        // You can add quantity if your model supports it
        // trailing: Text(widget.item.quantity ?? ''),
      ),
    );
  }
}
