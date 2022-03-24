import 'package:flutter/material.dart';
import './models/logical_board.dart';

class CellColor {
  static Map<CellStatus, Color> colorMap = {
    CellStatus.noStatus: Colors.white,
    CellStatus.correct: Colors.lightGreen.shade300,
    CellStatus.inWrongPlace: Colors.lightBlue.shade100,
    CellStatus.incorrect: Colors.red.shade200,
  };
}

class Cell extends StatelessWidget {
  final LogicalCell cell;
  final bool isActive;

  const Cell({Key? key, required this.cell, this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: CellColor.colorMap[cell.status],
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(cell.letter,
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
        ));
  }
}
