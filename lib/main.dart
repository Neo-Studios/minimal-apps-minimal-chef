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
          seedColor: const Color(0xFFD8BFD8),
          brightness: Brightness.light,
          primary: const Color(0xFFD8BFD8),
          secondary: const Color(0xFFFFB6C1),
          surface: const Color(0xFFF5F5F5),
          onSurface: const Color(0xFF333333),
        ),
        visualDensity: VisualDensity.standard,
        textTheme: TextTheme(
            displayLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12),
            displayMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.15),
            displaySmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.22),
            headlineLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.25),
            headlineMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.28),
            headlineSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.33),
            titleLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.27),
            titleMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.5),
            titleSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            bodyLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.5),
            bodyMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.42),
            bodySmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33),
            labelLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            labelMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33),
            labelSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45),
          ).apply(
            bodyColor: const Color(0xFF333333),
            displayColor: const Color(0xFF333333),
          ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC39BD3),
          brightness: Brightness.dark,
          primary: const Color(0xFFC39BD3),
          secondary: const Color(0xFFF48FB1),
          surface: const Color(0xFF1E1E1E),
          onSurface: const Color(0xFFFFFFFF),
        ),
        visualDensity: VisualDensity.standard,
        textTheme: TextTheme(
            displayLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25, height: 1.12),
            displayMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 45, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.15),
            displaySmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.22),
            headlineLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.25),
            headlineMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.28),
            headlineSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.33),
            titleLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 0, height: 1.27),
            titleMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, height: 1.5),
            titleSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            bodyLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.5),
            bodyMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.42),
            bodySmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33),
            labelLarge: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.42),
            labelMedium: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.33),
            labelSmall: const TextStyle(fontFamily: 'RobotoFlex', fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.45),
          ).apply(
            bodyColor: const Color(0xFFFFFFFF),
            displayColor: const Color(0xFFFFFFFF),
          ),
      ),
      home: const AuthGate(),
    );
  }
}
