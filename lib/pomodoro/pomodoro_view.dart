import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomotask/ui/button.dart';

class PomodoroView extends StatefulWidget {
  const PomodoroView({super.key});

  @override
  State<PomodoroView> createState() => _PomodoroViewState();
}

class _PomodoroViewState extends State<PomodoroView> {
  static const int _workDuration = 25 * 60;
  static const int _breakDuration = 5 * 60;
  int _secondsRemaining = _workDuration;
  Timer? _timer;
  bool _isRunning = false;
  bool _isBreak = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _isRunning = false;
          if (_isBreak) {
            _isBreak = false;
            _secondsRemaining = _workDuration;
          } else {
            _isBreak = true;
            _secondsRemaining = _breakDuration;
          }
        }
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _resetTimer(bool isBreak) {
    _timer?.cancel();
    setState(() {
      _isBreak = isBreak;
      _secondsRemaining = isBreak ? _breakDuration : _workDuration;
      _isRunning = false;
    });
  }

  void _finishSession() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isBreak = false;
      _secondsRemaining = _workDuration;
    });
    Navigator.pop(context);
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_secondsRemaining),
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: (_isBreak
                        ? _breakDuration - _secondsRemaining
                        : _workDuration - _secondsRemaining) /
                    (_isBreak ? _breakDuration : _workDuration),
                backgroundColor: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!_isRunning)
                Button(
                  onPressed: _startTimer,
                  child: const Text('Comenzar'),
                )
              else ...[
                Button(
                  onPressed: _finishSession,
                  child: const Text('Finalizar sesión'),
                ),
                const SizedBox(height: 16),
                !_isBreak
                    ? SimpleButton(
                        onPressed: () => _resetTimer(!_isBreak),
                        child: const Text('Descansar'),
                      )
                    : SimpleButton(
                        onPressed: () => _resetTimer(!_isBreak),
                        child: const Text('Trabajar'),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
