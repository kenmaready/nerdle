import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
  List<String> guesses = ["STARE", "GLARE"];
  int activeRow = 0;

  List<GameRow> _boardBuilder(LogicalBoard logicalBoard) {
    List<GameRow> uiBoard = [];
    // fill up rows for any prior guesses:
    if (logicalBoard.rows.length > 0) {
      for (WordModel guess in logicalBoard.rows) {
        uiBoard.add(GameRow.guessed(word: guess));
      }
    }

    // add current Row
    uiBoard.add(GameRow.current(
      wordSize: widget.wordSize,
    ));

    // add empty rows for rest of board
    for (int i = 0; i < widget.numGuesses - guesses.length - 1; i++) {
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
      uiBoard.add(GameRow.guessed(word: targetWordModel));
    }

    return uiBoard;
  }

  @override
  Widget build(BuildContext context) {
    LogicalBoard logicalBoard = LogicalBoard(targetWord);
    logicalBoard.addGuess(guesses[0]);
    logicalBoard.addGuess(guesses[1]);

    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Column(
        children: _boardBuilder(logicalBoard),
      ),
    );
  }
}
