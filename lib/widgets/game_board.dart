import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/puzzle.dart';
import '../models/word.dart';
import '../models/letter.dart';
import './game_row.dart';

class GameBoard extends StatelessWidget {
  final Puzzle puzzle;
  final Function(String) handleGuess;

  const GameBoard({Key? key, required this.puzzle, required this.handleGuess})
      : super(key: key);

  List<GameRow> _boardBuilder(Puzzle puzzle, Function(String) handleGuess) {
    List<GameRow> uiBoard = [];

    // fill up rows for any prior guesses:
    if (puzzle.guessesTaken > 0) {
      for (Word guess in puzzle.rows) {
        uiBoard.add(GameRow.guessed(word: guess));
      }
    }

    // add current Row
    if (puzzle.guessesRemaining > 0) {
      uiBoard.add(GameRow.current(
        wordSize: puzzle.wordSize,
        handleGuess: handleGuess,
      ));
    }

    // add empty rows for rest of board
    for (int i = 0; i < puzzle.guessesRemaining - 1; i++) {
      uiBoard.add(GameRow.empty(
        wordSize: puzzle.wordSize,
      ));
    }

    // for debugging purposes, add extra row with target word at bottom:
    if (kDebugMode) {
      Word targetAsWord = [];
      for (int i = 0; i < puzzle.wordSize; i++) {
        targetAsWord.add(Letter(
            letter: puzzle.targetWord[i], status: LetterStatus.noStatus));
      }
      uiBoard.add(GameRow.guessed(word: targetAsWord));
    }

    return uiBoard;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: _boardBuilder(puzzle, handleGuess),
    ));
  }
}
