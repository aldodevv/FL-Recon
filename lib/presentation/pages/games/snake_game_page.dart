
import 'dart:async';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  _SnakeGamePageState createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  static const int _gridSize = 20;
  List<Point<int>> _snake = [const Point(10, 10)];
  late Point<int> _food;
  Direction _direction = Direction.right;
  bool _isPlaying = false;
  int _score = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _snake = [const Point(10, 10)];
      _direction = Direction.right;
      _score = 0;
      _spawnFood();
      _isPlaying = true;
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 300), _updateGame);
    });
  }

  void _spawnFood() {
    final random = Random();
    int x, y;
    do {
      x = random.nextInt(_gridSize);
      y = random.nextInt(_gridSize);
    } while (_snake.contains(Point(x, y)));
    _food = Point(x, y);
  }

  void _updateGame(Timer timer) {
    if (!_isPlaying) return;

    setState(() {
      final head = _snake.first;
      Point<int> newHead;

      switch (_direction) {
        case Direction.up:
          newHead = Point(head.x, head.y - 1);
          break;
        case Direction.down:
          newHead = Point(head.x, head.y + 1);
          break;
        case Direction.left:
          newHead = Point(head.x - 1, head.y);
          break;
        case Direction.right:
          newHead = Point(head.x + 1, head.y);
          break;
      }

      // Check for collision with walls or self
      if (newHead.x < 0 || newHead.x >= _gridSize || newHead.y < 0 || newHead.y >= _gridSize || _snake.contains(newHead)) {
        _gameOver();
        return;
      }

      _snake.insert(0, newHead);

      if (newHead == _food) {
        _score++;
        _spawnFood();
      } else {
        _snake.removeLast();
      }
    });
  }

  void _gameOver() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Game'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 && _direction != Direction.up) {
            _direction = Direction.down;
          } else if (details.delta.dy < 0 && _direction != Direction.down) {
            _direction = Direction.up;
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && _direction != Direction.left) {
            _direction = Direction.right;
          } else if (details.delta.dx < 0 && _direction != Direction.right) {
            _direction = Direction.left;
          }
        },
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.black,
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _gridSize * _gridSize,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _gridSize,
                    ),
                    itemBuilder: (context, index) {
                      final x = index % _gridSize;
                      final y = index ~/ _gridSize;
                      final point = Point(x, y);
                      final isSnake = _snake.contains(point);
                      final isFood = point == _food;

                      return Container(
                        margin: const EdgeInsets.all(0.5),
                        decoration: BoxDecoration(
                          color: isSnake ? Colors.green : (isFood ? Colors.red : Colors.grey[900]),
                          shape: isSnake ? BoxShape.rectangle : BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Score: $_score',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
