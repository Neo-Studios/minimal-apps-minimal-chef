import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:minimal_chef/features/auth/services/auth_service.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    final authService = AuthService();
    await authService.signInWithGoogle();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLogo(theme),
                        const SizedBox(height: 48),
                        _buildWelcomeText(theme),
                        const SizedBox(height: 16),
                        _buildSubtitle(theme),
                        const SizedBox(height: 64),
                        _buildGlassCard(
                          child: Column(
                            children: [
                              _buildGoogleButton(theme),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildFooterText(theme),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(ThemeData theme) {
    return Container(
      width: 120,
      height: 120,
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
      child: Icon(
        Icons.restaurant_menu,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildWelcomeText(ThemeData theme) {
    return Text(
      'Welcome to Minimal Chef',
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF2F2F2F),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    return Text(
      'Your minimalist cooking companion',
      style: theme.textTheme.bodyLarge?.copyWith(
        color: const Color(0xFF2F2F2F).withValues(alpha: 0.7),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    final glassContainer = Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: kIsWeb 
            ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
            : const Color(0xFFFFFFFF).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFFA500).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: child,
    );

    if (kIsWeb) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: glassContainer,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: glassContainer,
      ),
    );
  }

  Widget _buildGoogleButton(ThemeData theme) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _isLoading ? null : _handleGoogleSignIn,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFA500)),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.google,
                      size: 24,
                      color: Color(0xFF2F2F2F),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Continue with Google',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2F2F2F),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFooterText(ThemeData theme) {
    return Text(
      'By continuing, you agree to our Terms & Privacy Policy',
      style: theme.textTheme.bodySmall?.copyWith(
        color: const Color(0xFF2F2F2F).withValues(alpha: 0.6),
      ),
      textAlign: TextAlign.center,
    );
  }
}
