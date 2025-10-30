import 'package:flutter/material.dart';
import 'package:flutter/physics.dart'; // Import this!

class SpringyButton extends StatefulWidget {
  const SpringyButton({super.key});

  @override
  State<SpringyButton> createState() => _SpringyButtonState();
}

class _SpringyButtonState extends State<SpringyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late SpringSimulation _simulation;
  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // Note: No duration!
      lowerBound: double.negativeInfinity,
      upperBound: double.infinity,
    );

    _controller.addListener(() {
      setState(() {
        _dragAlignment = Alignment(_controller.value, 0);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() {
    // Define the spring
    _simulation = SpringSimulation(
      const SpringDescription(
        mass: 1.0,
        stiffness: 180.0, // Adjust for more/less stiffness
        damping: 10.0,    // Adjust for more/less bounce
      ),
      _controller.value, // Start position
      0.0,               // End position (center)
      _controller.velocity, // Current velocity
    );

    // Run the physics simulation
    _controller.animateWith(_simulation);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          // Translate drag pixels to alignment values
          _dragAlignment += Alignment(details.delta.dx / 100, 0);
          _controller.value = _dragAlignment.x;
        });
      },
      onPanEnd: (details) {
        _runAnimation(); // Spring back!
      },
      child: Align(
        alignment: _dragAlignment,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Drag and Release Me'),
        ),
      ),
    );
  }
}