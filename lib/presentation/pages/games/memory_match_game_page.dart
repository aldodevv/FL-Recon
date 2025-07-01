
import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MemoryMatchGamePage extends StatefulWidget {
  const MemoryMatchGamePage({super.key});

  @override
  _MemoryMatchGamePageState createState() => _MemoryMatchGamePageState();
}

class _MemoryMatchGamePageState extends State<MemoryMatchGamePage> {
  late List<GameCard> _cards;
  GameCard? _firstCard, _secondCard;
  bool _isChecking = false;
  int _pairsFound = 0;

  @override
  void initState() {
    super.initState();
    _setupGame();
  }

  void _setupGame() {
    _pairsFound = 0;
    final List<IconData> icons = [
      Icons.pets, Icons.star, Icons.favorite, Icons.anchor,
      Icons.camera, Icons.lightbulb, Icons.ac_unit, Icons.wb_sunny,
    ];
    _cards = [...icons, ...icons].map((icon) => GameCard(icon: icon)).toList();
    _cards.shuffle();
    setState(() {});
  }

  void _onCardTapped(int index) {
    if (_isChecking || _cards[index].isMatched || _cards[index].isFlipped) {
      return;
    }

    setState(() {
      _cards[index].isFlipped = true;
      if (_firstCard == null) {
        _firstCard = _cards[index];
      } else {
        _secondCard = _cards[index];
        _isChecking = true;
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() {
    if (_firstCard!.icon == _secondCard!.icon) {
      // It's a match!
      setState(() {
        _firstCard!.isMatched = true;
        _secondCard!.isMatched = true;
        _pairsFound++;
        _resetTurn();
        if (_pairsFound == 8) {
          _showGameWonDialog();
        }
      });
    } else {
      // Not a match, flip back
      Timer(const Duration(milliseconds: 800), () {
        setState(() {
          _firstCard!.isFlipped = false;
          _secondCard!.isFlipped = false;
          _resetTurn();
        });
      });
    }
  }

  void _resetTurn() {
    _firstCard = null;
    _secondCard = null;
    _isChecking = false;
  }

  void _showGameWonDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You found all the pairs!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setupGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _setupGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: _cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onCardTapped(index),
              child: Card(
                color: _cards[index].isFlipped ? Colors.white : Colors.blue,
                child: _cards[index].isFlipped
                    ? Icon(_cards[index].icon, size: 40)
                    : const SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GameCard {
  final IconData icon;
  bool isFlipped = false;
  bool isMatched = false;

  GameCard({required this.icon});
}
