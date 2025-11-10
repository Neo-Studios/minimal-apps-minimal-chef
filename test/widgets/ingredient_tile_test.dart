import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';
import 'package:minimal_chef/features/shopping_list/screens/shopping_list_screen.dart';

void main() {
  group('IngredientTile Widget', () {
    testWidgets('displays ingredient name', (WidgetTester tester) async {
      final ingredient = Ingredient(name: 'Tomatoes', quantity: '3');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientTile(item: ingredient),
          ),
        ),
      );

      expect(find.text('Tomatoes'), findsOneWidget);
    });

    testWidgets('checkbox toggles on tap', (WidgetTester tester) async {
      final ingredient = Ingredient(name: 'Onions');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientTile(item: ingredient),
          ),
        ),
      );

      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);

      await tester.tap(checkbox);
      await tester.pump();

      final Checkbox checkboxWidget = tester.widget(checkbox);
      expect(checkboxWidget.value, true);
    });

    testWidgets('text has strikethrough when checked', (WidgetTester tester) async {
      final ingredient = Ingredient(name: 'Garlic');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientTile(item: ingredient),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final Text textWidget = tester.widget(find.text('Garlic'));
      expect(textWidget.style?.decoration, TextDecoration.lineThrough);
    });
  });
}
