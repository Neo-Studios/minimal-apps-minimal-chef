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
        visualDensity: VisualDensity.standard,
        textTheme: TextTheme(
            displayLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12),
            displayMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.15),
            displaySmall: const TextStyle(fontFamily: 'Roboto', fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.22),
            headlineLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.25),
            headlineMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.28),
            headlineSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.33),
            titleLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.27),
            titleMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.5),
            titleSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            bodyLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.5),
            bodyMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.42),
            bodySmall: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33),
            labelLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            labelMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33),
            labelSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45),
          ).apply(
            bodyColor: const Color(0xFF2F2F2F),
            displayColor: const Color(0xFF2F2F2F),
          ),
        targetPlatform: TargetPlatform.android,
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
        visualDensity: VisualDensity.standard,
        textTheme: TextTheme(
            displayLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12),
            displayMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.15),
            displaySmall: const TextStyle(fontFamily: 'Roboto', fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.22),
            headlineLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.25),
            headlineMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.28),
            headlineSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.33),
            titleLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.27),
            titleMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.5),
            titleSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            bodyLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.5),
            bodyMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.42),
            bodySmall: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33),
            labelLarge: const TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            labelMedium: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33),
            labelSmall: const TextStyle(fontFamily: 'Roboto', fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45),
          ).apply(
            bodyColor: const Color(0xFFFFF8E1),
            displayColor: const Color(0xFFFFF8E1),
          ),
        targetPlatform: TargetPlatform.android,
      ),
      home: const AuthGate(),
    );
  }
}
