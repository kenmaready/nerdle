import 'package:flutter/material.dart';
import 'game_cell.dart';
import 'models/logical_board.dart';

class GameRow extends StatefulWidget {
  final int wordSize;
  final bool isActive;
  WordModel word;

  GameRow.empty(
      {Key? key,
      required this.wordSize,
      this.word = const [],
      this.isActive = false})
      : super(key: key);

  GameRow.current({
    Key? key,
    required this.wordSize,
  })  : word = [],
        isActive = true,
        super(key: key);

  GameRow.guessed({Key? key, required this.word})
      : wordSize = word.length,
        isActive = false,
        super(key: key);

  @override
  State<GameRow> createState() => _GameRowState();
}

class _GameRowState extends State<GameRow> {
  int activeCell = 0;
  String guess = "";

  List<Cell> _rowBuilder() {
    List<Cell> row = [];

    // if row has already been guessed, produce row with word in it:
    if (widget.word.isNotEmpty) {
      for (int i = 0; i < widget.word.length; i++) {
        row.add(Cell(cell: widget.word[i]));
      }
      return row;
    }

    // Otherwise build row letter by letter:
    // First, fill cells with letters guessed so far:
    if (guess.isNotEmpty) {
      for (int i = 0; i < guess.length; i++) {
        print('Adding cell ${i} which is ${guess[i]}...');
        row.add(Cell(
            cell: LogicalCell(letter: guess[i], status: CellStatus.noStatus)));
      }
    }

    // if guess doesn't fill up row, add active cell:
    if (row.length < widget.wordSize) {
      row.add(Cell(
        cell: LogicalCell(letter: " ", status: CellStatus.noStatus),
        isActive: true,
      ));
    }

    // fill out remainder of row with empty cells:
    if (row.length < widget.wordSize) {
      for (int i = 0; i < this.widget.wordSize - guess.length - 1; i++) {
        row.add(
            Cell(cell: LogicalCell(letter: " ", status: CellStatus.noStatus)));
      }
    }

    return row;
  }

  @override
  Widget build(BuildContext context) {
    Widget row = Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _rowBuilder(),
        ));

    if (widget.isActive) {
      row = KeyboardListener(
          focusNode: FocusNode(),
          onKeyEvent: (KeyEvent k) {
            print("Key pressed...");
          },
          child: row);
    }

    return row;
  }
}
