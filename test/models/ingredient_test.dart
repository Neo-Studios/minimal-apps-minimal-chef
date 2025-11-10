import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_chef/features/recipe/models/ingredient.dart';

void main() {
  group('Ingredient Model', () {
    test('creates ingredient with name and quantity', () {
      final ingredient = Ingredient(name: 'Sugar', quantity: '1 cup');

      expect(ingredient.name, 'Sugar');
      expect(ingredient.quantity, '1 cup');
    });

    test('creates ingredient without quantity', () {
      final ingredient = Ingredient(name: 'Salt');

      expect(ingredient.name, 'Salt');
      expect(ingredient.quantity, null);
    });

    test('toMap converts ingredient to map', () {
      final ingredient = Ingredient(name: 'Flour', quantity: '2 cups');
      final map = ingredient.toMap();

      expect(map['name'], 'Flour');
      expect(map['quantity'], '2 cups');
    });

    test('fromMap creates ingredient from map', () {
      final map = {'name': 'Butter', 'quantity': '100g'};
      final ingredient = Ingredient.fromMap(map);

      expect(ingredient.name, 'Butter');
      expect(ingredient.quantity, '100g');
    });

    test('fromJson creates ingredient from json', () {
      final json = {'name': 'Eggs', 'quantity': '3'};
      final ingredient = Ingredient.fromJson(json);

      expect(ingredient.name, 'Eggs');
      expect(ingredient.quantity, '3');
    });
  });
}
