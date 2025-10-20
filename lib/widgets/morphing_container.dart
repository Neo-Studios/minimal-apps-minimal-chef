import 'package:flutter/material.dart';

class MorphingContainer extends StatefulWidget {
  const MorphingContainer({super.key});

  @override
  State<MorphingContainer> createState() => _MorphingContainerState();
}

class _MorphingContainerState extends State<MorphingContainer> {
  bool _isMorphed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => setState(() => _isMorphed = !_isMorphed),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn, // Use an expressive curve
        width: _isMorphed ? 100 : 200,
        height: 100,
        decoration: BoxDecoration(
          color: colorScheme.tertiaryContainer,
          // This animates the shape
          borderRadius: _isMorphed
              ? BorderRadius.circular(50) // Circle
              : BorderRadius.circular(16), // Rounded rect
        ),
        child: Center(
          child: Text(
            'Tap Me',
            style: TextStyle(color: colorScheme.onTertiaryContainer),
          ),
        ),
      ),
    );
  }
}