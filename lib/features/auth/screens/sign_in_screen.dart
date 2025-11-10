import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minimal_chef/features/auth/screens/email_password_login_screen.dart';
import 'package:minimal_chef/features/auth/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8E1),
              Color(0xFFFFE4B5),
              Color(0xFFFFEFD5),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 48),
                    Text(
                      'Minimal Chef',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2F2F2F),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your minimalist cooking companion',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF2F2F2F).withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 64),
                    _buildSignInButton(
                      context,
                      icon: FontAwesomeIcons.google,
                      iconColor: const Color(0xFFDB4437),
                      text: 'Continue with Google',
                      onTap: _isLoading ? null : _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 16),
                    _buildSignInButton(
                      context,
                      icon: FontAwesomeIcons.envelope,
                      iconColor: const Color(0xFF2F2F2F),
                      text: 'Continue with Email',
                      onTap: _isLoading
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const EmailPasswordLoginScreen(),
                                ),
                              );
                            },
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'By continuing, you agree to our Terms & Privacy Policy',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF2F2F2F).withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFA500),
            Color(0xFFFF6F61),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x4DFFA500),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.restaurant_menu,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await AuthService().signInWithGoogle();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign-in failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildSignInButton(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String text,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: _isLoading && onTap == null
              ? const Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(icon, color: iconColor, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2F2F2F),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}