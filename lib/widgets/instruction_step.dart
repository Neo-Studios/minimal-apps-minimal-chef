import 'package:flutter/material.dart';
import 'dart:async';

class InstructionStep extends StatefulWidget {
  final String instruction;
  final int stepNumber;

  const InstructionStep({
    super.key,
    required this.instruction,
    required this.stepNumber,
  });

  @override
  State<InstructionStep> createState() => _InstructionStepState();
}

class _InstructionStepState extends State<InstructionStep> {
  Timer? _timer;
  int? _duration;
  int _remainingTime = 0;
  bool _isTimerRunning = false;
  bool _isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    _duration = _parseTime(widget.instruction);
    if (_duration != null) {
      _remainingTime = _duration!;
    }
  }

  int? _parseTime(String instruction) {
    final RegExp regex = RegExp(r'(\d+)\s+(minutes|minute|hours|hour)');
    final Match? match = regex.firstMatch(instruction);

    if (match != null) {
      final int time = int.parse(match.group(1)!);
      final String unit = match.group(2)!;

      if (unit.startsWith('minute')) {
        return time * 60;
      } else if (unit.startsWith('hour')) {
        return time * 3600;
      }
    }
    return null;
  }

  void _startTimer() {
    if (_duration != null) {
      setState(() {
        _isTimerRunning = true;
        _isTimerFinished = false;
        _remainingTime = _duration!;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            _timer?.cancel();
            _isTimerRunning = false;
            _isTimerFinished = true;
          }
        });
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
    });
  }

    void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _isTimerFinished = false;
      if (_duration != null) {
        _remainingTime = _duration!;
      }
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${widget.stepNumber}.'),
      title: Text(widget.instruction),
      trailing: _duration != null
          ? SizedBox(
              width: 120,
              child: Row(
                children: [
                  if (!_isTimerRunning && !_isTimerFinished)
                    ElevatedButton(
                      onPressed: _startTimer,
                      child: const Text('Start'),
                    ),
                  if (_isTimerRunning)
                    ElevatedButton(
                      onPressed: _stopTimer,
                      child: const Text('Stop'),
                    ),
                   if (_isTimerFinished)
                    ElevatedButton(
                      onPressed: _resetTimer,
                      child: const Text('Reset'),
                    ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(_remainingTime),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
