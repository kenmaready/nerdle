import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/puzzle.dart';
import '../models/letter.dart';

class CellColor {
  static Map<LetterStatus, Color> colorMap = {
    LetterStatus.noStatus: Colors.white,
    LetterStatus.correct: Colors.lightGreen.shade300,
    LetterStatus.inWrongPlace: Colors.lightBlue.shade100,
    LetterStatus.incorrect: Colors.red.shade200,
  };
}

class Cell extends StatelessWidget {
  final Letter letter;

  const Cell({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: CellColor.colorMap[letter.status],
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: (Text(letter.letter,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)))));
  }
}
