import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class AdvancedMorph extends StatefulWidget {
  const AdvancedMorph({super.key});

  @override
  State<AdvancedMorph> createState() => _AdvancedMorphState();
}

class _AdvancedMorphState extends State<AdvancedMorph> {
  bool _isMorphed = false;

  // Define two different, complex shapes
  final ShapeBorder rectShape = RoundedRectangleShapeBorder(
    borderRadius: DynamicBorderRadius.all(const Length(20)),
  );

  final ShapeBorder starShape = StarShapeBorder(
    corners: 5,
    inset: const Length(40, unit: LengthUnit.percent),
    borderRadius: DynamicBorderRadius.all(const Length(10)),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isMorphed = !_isMorphed),
      child: AnimatedDecoratedShape(
        duration: const Duration(milliseconds: 700),
        curve: Curves.spring( // Use a spring curve!
          damping: 10,
          stiffness: 180,
        ),
        shape: _isMorphed ? starShape : rectShape, // Animate the shape
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: const SizedBox(
          width: 200,
          height: 200,
          child: Center(child: Text('Tap to Morph')),
        ),
      ),
    );
  }
}