import 'package:flutter/material.dart';
import 'package:minimal_chef/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AuthService().signOut(),
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
