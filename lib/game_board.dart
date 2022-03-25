import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './main.dart';
import 'game_row.dart';
import 'models/logical_board.dart';

class GameBoard extends StatefulWidget {
  final int numGuesses;
  final int wordSize;

  const GameBoard({Key? key, this.numGuesses = 5, this.wordSize = 5})
      : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final String targetWord = "BEAST";
  List<String> guesses = ["PASTY", "FEAST"];
  late LogicalBoard logicalBoard;
  late int remainingGuesses;
  int counter = 1;

  List<GameRow> _boardBuilder(
      LogicalBoard logicalBoard, Function(String) handleGuess) {
    List<GameRow> uiBoard = [];

    // fill up rows for any prior guesses:
    if (logicalBoard.rows.length > 0) {
      for (WordModel guess in logicalBoard.rows) {
        String guessWord = "";
        for (int i = 0; i < guess.length; i++) {
          guessWord += guess[i].letter;
        }
        print("Adding row ${counter++} to board (a guess: ${guessWord})...");
        uiBoard.add(GameRow.guessed(word: guess));
      }
    }

    // add current Row
    print("Adding row ${counter++} to board (current row)...");
    uiBoard.add(GameRow.current(
      wordSize: widget.wordSize,
      handleGuess: handleGuess,
    ));

    // add empty rows for rest of board
    for (int i = 0; i < widget.numGuesses - logicalBoard.rows.length - 1; i++) {
      print("Adding row ${counter++} to board (empty row)...");
      uiBoard.add(GameRow.empty(
        wordSize: widget.wordSize,
      ));
    }

    // for debugging purposes, add extra row with target word at bottom:
    if (kDebugMode) {
      WordModel targetWordModel = [];
      for (int i = 0; i < targetWord.length; i++) {
        targetWordModel.add(
            LogicalCell(letter: targetWord[i], status: CellStatus.noStatus));
      }
      print("Adding row ${counter++} to board (targetWord)...");
      uiBoard.add(GameRow.guessed(word: targetWordModel));
    }

    return uiBoard;
  }

  void _reset() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: "nerdle")));
  }

  void submitGuess(String guess) {
    setState(() {
      logicalBoard.addGuess(guess);
      remainingGuesses--;
    });

    // check if guessed correctly:
    if (logicalBoard.guessed) {
      print("YOU GOT IT! PLAY AGAIN!");
      _reset();
    }

    // check if out of turns:
    if (remainingGuesses <= 0) {
      print("Out of Turns, sorry, try again.");
      _reset();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // reset board:
    logicalBoard = LogicalBoard(targetWord);
    logicalBoard.addGuess(guesses[0]); // testing only
    logicalBoard.addGuess(guesses[1]); // testing only

    // reset guessCounter:
    remainingGuesses = widget.numGuesses;
    remainingGuesses -= 2; // testing only
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: ListView(
        children: _boardBuilder(logicalBoard, submitGuess),
      ),
    );
  }
}
