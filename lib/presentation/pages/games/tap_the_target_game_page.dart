import 'dart:async';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TapTheTargetGamePage extends StatefulWidget {
  const TapTheTargetGamePage({super.key});

  @override
  TapTheTargetGamePageState createState() => TapTheTargetGamePageState();
}

class TapTheTargetGamePageState extends State<TapTheTargetGamePage> {
  static const int _gridSize = 4;
  static const int _gameDurationInSeconds = 30;

  int? _targetIndex;
  int _score = 0;
  int _timeLeft = _gameDurationInSeconds;
  bool _isPlaying = false;
  Timer? _timer;
  Timer? _targetTimer;

  @override
  void initState() {
    super.initState();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = _gameDurationInSeconds;
      _isPlaying = true;
      _spawnTarget();

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _timeLeft--;
          if (_timeLeft <= 0) {
            _gameOver();
          }
        });
      });
    });
  }

  void _spawnTarget() {
    final random = Random();
    _targetTimer?.cancel();
    _targetTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!_isPlaying) return timer.cancel();
      setState(() {
        _targetIndex = random.nextInt(_gridSize * _gridSize);
      });
    });
  }

  void _onTileTapped(int index) {
    if (!_isPlaying || index != _targetIndex) return;

    setState(() {
      _score++;
      _targetIndex = null; // Hide target immediately
      _spawnTarget(); // Respawn target faster
    });
  }

  void _gameOver() {
    _timer?.cancel();
    _targetTimer?.cancel();
    setState(() {
      _isPlaying = false;
      _targetIndex = null;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Over'),
            content: Text('Your final score: $_score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _targetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap The Target'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              _isPlaying ? 'Time: $_timeLeft' : 'Tap Start to Play',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _gridSize * _gridSize,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridSize,
                ),
                itemBuilder: (context, index) {
                  final isTarget = index == _targetIndex;
                  return GestureDetector(
                    onTap: () => _onTileTapped(index),
                    child: Card(
                      color: isTarget ? Colors.redAccent : Colors.blueGrey[100],
                      child: Center(
                        child:
                            isTarget
                                ? Image.network(
                                  'https://i.pinimg.com/474x/e3/5d/ed/e35ded8d32daa3968ef1cb94c7c057cc.jpg',
                                )
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Score: $_score',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (!_isPlaying)
            ElevatedButton(
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
