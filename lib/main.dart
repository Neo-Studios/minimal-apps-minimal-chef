import 'package:flutter/material.dart';
import 'package:minimal_chef/screens/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MinimalChefApp());
}

class MinimalChefApp extends StatelessWidget {
  const MinimalChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Chef',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA500),
          brightness: Brightness.light,
          primary: const Color(0xFFFFA500),
          secondary: const Color(0xFF00B4D8),
          surface: const Color(0xFFFFF8E1),
          onSurface: const Color(0xFF2F2F2F),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Times New Roman'),
          displayMedium: TextStyle(fontFamily: 'Times New Roman'),
          displaySmall: TextStyle(fontFamily: 'Times New Roman'),
          headlineLarge: TextStyle(fontFamily: 'Times New Roman'),
          headlineMedium: TextStyle(fontFamily: 'Times New Roman'),
          headlineSmall: TextStyle(fontFamily: 'Times New Roman'),
          titleLarge: TextStyle(fontFamily: 'Times New Roman'),
          titleMedium: TextStyle(fontFamily: 'Times New Roman'),
          titleSmall: TextStyle(fontFamily: 'Times New Roman'),
          bodyLarge: TextStyle(fontFamily: 'Noto Sans'),
          bodyMedium: TextStyle(fontFamily: 'Noto Sans'),
          bodySmall: TextStyle(fontFamily: 'Noto Sans'),
          labelLarge: TextStyle(fontFamily: 'Noto Sans'),
          labelMedium: TextStyle(fontFamily: 'Noto Sans'),
          labelSmall: TextStyle(fontFamily: 'Noto Sans'),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA500),
          brightness: Brightness.dark,
          primary: const Color(0xFFFFA500),
          secondary: const Color(0xFF00B4D8),
          surface: const Color(0xFF2F2F2F),
          onSurface: const Color(0xFFFFF8E1),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          displayMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          displaySmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          headlineSmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleLarge: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleMedium: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          titleSmall: TextStyle(fontFamily: 'Times New Roman', color: Color(0xFFFFF8E1)),
          bodyLarge: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          bodyMedium: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          bodySmall: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelLarge: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelMedium: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
          labelSmall: TextStyle(fontFamily: 'Noto Sans', color: Color(0xFFFFF8E1)),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
