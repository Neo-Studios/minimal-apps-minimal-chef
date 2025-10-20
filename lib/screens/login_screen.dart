import 'package:flutter/material.dart';
import 'package:minimal_chef/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final user = await authService.signInWithGoogle();
            if (user != null) {
              // Navigate to the home screen or another screen
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
