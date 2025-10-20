import 'package:flutter/material.dart';
import 'package:minimal_chef/services/auth_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Minimal Chef',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => AuthService().signInWithGoogle(),
              child: const Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
