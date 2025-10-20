import 'dart.ui'; // Import this for FontVariation
import 'package:flutter/material.dart';

class VariableFontText extends StatefulWidget {
  const VariableFontText({super.key});

  @override
  State<VariableFontText> createState() => _VariableFontTextState();
}

class _VariableFontTextState extends State<VariableFontText> {
  bool _isHeavy = false;

  @override
  Widget build(BuildContext context) {
    // 'wght' is the standard axis tag for font weight
    // Roboto Flex's weight axis (wght) ranges from 100 to 1000
    final double weight = _isHeavy ? 900.0 : 300.0;

    return GestureDetector(
      onTap: () => setState(() => _isHeavy = !_isHeavy),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        style: TextStyle(
          fontFamily: 'RobotoFlex', // Use your variable font
          fontSize: 48,
          color: Theme.of(context).colorScheme.primary,
          // This is the key property!
          fontVariations: [
            FontVariation('wght', weight),
          ],
        ),
        child: const Text('Tap to Animate'),
      ),
    );
  }
}