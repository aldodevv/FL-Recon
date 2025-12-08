import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WordleGamePage extends StatefulWidget {
  const WordleGamePage({super.key});

  @override
  WordleGamePageState createState() => WordleGamePageState();
}

class WordleGamePageState extends State<WordleGamePage> {
  // Corrected: Word list now only contains 5-letter words.
  static const List<String> _wordList = [
    'FLAME',
    'APPLE',
    'WORLD',
    'GREAT',
    'STATE',
  ];
  static const int _wordLength = 5;
  static const int _maxAttempts = 4;

  late String _secretWord;
  final List<WordGuess> _guesses = [];
  String _currentGuess = '';
  int _currentAttempt = 0;
  bool _isGameOver = false;
  final Set<String> _guessedLetters = {};

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _secretWord = _wordList[Random().nextInt(_wordList.length)];
      _guesses.clear();
      _currentGuess = '';
      _currentAttempt = 0;
      _isGameOver = false;
      _guessedLetters.clear();
      // For debugging purposes, you can uncomment the line below
      // print('Secret Word: $_secretWord');
    });
  }

  void _onKeyPressed(String letter) {
    if (_isGameOver) return;

    setState(() {
      if (letter == 'ENTER') {
        if (_currentGuess.length == _wordLength) {
          _submitGuess();
        }
      } else if (letter == 'BACKSPACE') {
        if (_currentGuess.isNotEmpty) {
          _currentGuess = _currentGuess.substring(0, _currentGuess.length - 1);
        }
      } else if (_currentGuess.length < _wordLength) {
        _currentGuess += letter;
      }
    });
  }

  void _submitGuess() {
    final guess = WordGuess(_currentGuess);
    for (int i = 0; i < _wordLength; i++) {
      if (_currentGuess[i] == _secretWord[i]) {
        guess.statuses[i] = LetterStatus.correct;
      } else if (_secretWord.contains(_currentGuess[i])) {
        guess.statuses[i] = LetterStatus.present;
      } else {
        guess.statuses[i] = LetterStatus.absent;
      }
      _guessedLetters.add(_currentGuess[i]);
    }

    setState(() {
      _guesses.add(guess);
      _currentAttempt++;
      _currentGuess = '';

      if (guess.word == _secretWord) {
        _isGameOver = true;
        _showEndGameDialog('You Won!');
      } else if (_currentAttempt >= _maxAttempts) {
        _isGameOver = true;
        _showEndGameDialog('You Lost! The word was $_secretWord');
      }
    });
  }

  void _showEndGameDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Over'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _startNewGame();
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
      appBar: AppBar(title: const Text('Wordle Game')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildGuessGrid(),
            ),
          ),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildGuessGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _wordLength * _maxAttempts,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _wordLength,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ _wordLength;
        final col = index % _wordLength;

        String letter = '';
        LetterStatus status = LetterStatus.empty;

        if (row < _guesses.length) {
          letter = _guesses[row].word[col];
          status = _guesses[row].statuses[col];
        } else if (row == _guesses.length && col < _currentGuess.length) {
          letter = _currentGuess[col];
        }

        return GridTile(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: status.color,
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeyboard() {
    const List<String> row1 = [
      'Q',
      'W',
      'E',
      'R',
      'T',
      'Y',
      'U',
      'I',
      'O',
      'P',
    ];
    const List<String> row2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    const List<String> row3 = [
      'ENTER',
      'Z',
      'X',
      'C',
      'V',
      'B',
      'N',
      'M',
      'BACKSPACE',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, left: 4, right: 4),
      child: Column(
        children: [
          _buildKeyboardRow(row1),
          const SizedBox(height: 4),
          _buildKeyboardRow(row2),
          const SizedBox(height: 4),
          _buildKeyboardRow(row3),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          keys.map((key) {
            final isSpecialKey = key == 'ENTER' || key == 'BACKSPACE';
            final color = _getKeyColor(key);

            return Expanded(
              flex: isSpecialKey ? 2 : 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: MaterialButton(
                  onPressed: () => _onKeyPressed(key),
                  color: color,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child:
                      isSpecialKey
                          ? Icon(
                            key == 'ENTER' ? Icons.check : Icons.backspace,
                            color: Colors.white,
                          )
                          : Text(
                            key,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Color _getKeyColor(String key) {
    if (_guessedLetters.contains(key)) {
      // This is a simplification. A full implementation would track correct/present status.
      return Colors.grey.shade800;
    }
    return Colors.blueGrey;
  }
}

enum LetterStatus { empty, correct, present, absent }

extension LetterStatusColor on LetterStatus {
  Color get color {
    switch (this) {
      case LetterStatus.correct:
        return Colors.green;
      case LetterStatus.present:
        return Colors.orange;
      case LetterStatus.absent:
        return Colors.grey.shade700;
      default:
        return Colors.grey.shade200;
    }
  }
}

class WordGuess {
  final String word;
  final List<LetterStatus> statuses;

  WordGuess(this.word)
    : statuses = List.filled(word.length, LetterStatus.empty);
}
