// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_chef/main.dart';

void main() {
  testWidgets('App initializes without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MinimalChefApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const MinimalChefApp());
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.title, 'Minimal Chef');
  });

  testWidgets('App uses Material 3', (WidgetTester tester) async {
    await tester.pumpWidget(const MinimalChefApp());
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.useMaterial3, true);
    expect(app.darkTheme?.useMaterial3, true);
  });

  testWidgets('Debug banner is disabled', (WidgetTester tester) async {
    await tester.pumpWidget(const MinimalChefApp());
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.debugShowCheckedModeBanner, false);
  });
}
