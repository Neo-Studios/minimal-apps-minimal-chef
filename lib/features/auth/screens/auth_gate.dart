import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_chef/features/home/screens/home_screen.dart';
import 'package:minimal_chef/features/auth/screens/sign_in_screen.dart';
import 'package:minimal_chef/features/auth/services/auth_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
