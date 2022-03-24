import 'package:flutter/material.dart';
import 'game_row.dart';

class GameBoard extends StatefulWidget {
  final int numGuesses;
  final int wordSize;

  const GameBoard({Key? key, this.numGuesses = 5, this.wordSize = 5})
      : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<GameRow> _boardBuilder() {
    List<GameRow> board = [];
    for (int i = 0; i < widget.numGuesses; i++) {
      board.add(GameRow(
        wordSize: widget.wordSize,
      ));
    }
    return board;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Column(
        children: _boardBuilder(),
      ),
    );
  }
}
