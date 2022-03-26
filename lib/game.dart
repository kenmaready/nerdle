import 'package:flutter/material.dart';
import 'dart:math';
import './main.dart';
import './widgets/game_board.dart';
import './models/puzzle.dart';
import './utils/load_words.dart';

class Game extends StatefulWidget {
  final int numGuesses;
  final int wordSize;
  final String wordSource;

  const Game(
      {Key? key,
      this.numGuesses = 5,
      this.wordSize = 5,
      required this.wordSource})
      : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<String> _words;
  final Random _random = Random();
  late String targetWord;
  late Puzzle puzzle;
  bool boardReady = false;

  void _reset() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "nerdle")));
  }

  void showAlertDialog(BuildContext context, String message) {
    // set up button
    Widget playAgainButton =
        ElevatedButton(onPressed: _reset, child: const Text("Play Again"));

    // set up dialog
    AlertDialog dialog = AlertDialog(
        title: Text(message),
        alignment: Alignment.topCenter,
        actions: [playAgainButton]);

    // show dialog:
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  void submitGuess(String guess) {
    setState(() {
      puzzle.guess(guess);
    });

    // check if guessed correctly:
    if (puzzle.success) {
      showAlertDialog(
          context, "You got it in ${puzzle.guessesTaken} guesses! Nice work!");
    } else if (puzzle.fail) {
      showAlertDialog(context, "Sorry, you ran out of guesses");
    }
  }

  _setup() async {
    // get words
    List<String> words = await loadWords(widget.wordSource);
    words.forEach((word) => print(word)); // TESTING
    setState(() {
      _words = words;
      String targetWord = _words[_random.nextInt(_words.length)];
      print("targetWord is: ${targetWord}"); // TESTING
      puzzle = Puzzle(targetWord: targetWord);
      boardReady = true;
    });
  }

  @override
  void initState() {
    super.initState();

    // reset board and targetWord:
    _setup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: boardReady
          ? GameBoard(puzzle: puzzle, handleGuess: submitGuess)
          : Center(child: Text("Waiting on words to be loaded...")),
    );
  }
}
