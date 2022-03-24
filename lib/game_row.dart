import 'package:flutter/material.dart';
import 'game_cell.dart';

class GameRow extends StatelessWidget {
  final int wordSize;

  const GameRow({Key? key, required this.wordSize}) : super(key: key);

  List<Cell> _rowBuilder() {
    List<Cell> row = [];
    for (int i = 0; i < this.wordSize; i++) {
      row.add(Cell(char: "T"));
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _rowBuilder(),
        ));
  }
}
