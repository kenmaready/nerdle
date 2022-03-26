import 'package:flutter/material.dart';
import '../models/puzzle.dart';
import '../models/word.dart';
import './game_row.dart';

class GameBoard extends StatelessWidget {
  final Puzzle puzzle;
  final Function(String) handleGuess;

  const GameBoard({Key? key, required this.puzzle, required this.handleGuess})
      : super(key: key);

  List<GameRow> _boardBuilder(Puzzle puzzle, Function(String) handleGuess) {
    List<GameRow> uiBoard = [];

    // fill up rows for any prior guesses:
    if (puzzle.rows.length > 0) {
      for (Word guess in puzzle.rows) {
        String guessWord = "";
        for (int i = 0; i < guess.length; i++) {
          guessWord += guess[i].letter;
        }

        uiBoard.add(GameRow.guessed(word: guess));
      }
    }

    // add current Row
    if (remainingGuesses > 0) {
      uiBoard.add(GameRow.current(
        wordSize: wordSize,
        handleGuess: handleGuess,
      ));
    }

    // add empty rows for rest of board
    for (int i = 0; i < numGuesses - puzzle.rows.length - 1; i++) {
      uiBoard.add(GameRow.empty(
        wordSize: wordSize,
      ));
    }

    // for debugging purposes, add extra row with target word at bottom:
    if (kDebugMode) {
      WordModel targetWordModel = [];
      for (int i = 0; i < puzzle.targetWord.length; i++) {
        targetWordModel.add(Letter(
            letter: puzzle.targetWord[i], status: LetterStatus.noStatus));
        uiBoard.add(GameRow.guessed(word: targetWordModel));
      }
    }

    return uiBoard;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
