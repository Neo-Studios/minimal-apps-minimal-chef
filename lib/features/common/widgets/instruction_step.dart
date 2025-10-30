import 'package:flutter/material.dart';

class InstructionStep extends StatelessWidget {
  final int stepNumber;
  final String instruction;

  const InstructionStep(
      {super.key, required this.stepNumber, required this.instruction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            child: Text(
              '$stepNumber',
              style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(instruction, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
