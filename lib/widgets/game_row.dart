import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_cell.dart';
import '../models/puzzle.dart';
import '../models/word.dart';
import '../models/letter.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class GameRow extends StatefulWidget {
  final int wordSize;
  final bool isActive;
  final Word word;
  Function(String)? handleGuess;

  GameRow.empty(
      {Key? key,
      required this.wordSize,
      this.word = const [],
      this.isActive = false})
      : super(key: key);

  GameRow.current({Key? key, required this.wordSize, required this.handleGuess})
      : word = [],
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
  TextEditingController? controller;
  FocusNode? focusNode;
  List<Cell> inputRow = [];

  @override
  void initState() {
    super.initState();
    // if (widget.isActive) {
    //   controller = TextEditingController();
    //   focusNode = FocusNode();
    //   FocusScope.of(context).requestFocus(focusNode);
    // }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isActive) {
      controller?.dispose();
      focusNode?.dispose();
    }
  }

  List<Cell> _rowBuilder() {
    List<Cell> row = [];

    // if row has already been guessed, produce row with word in it:
    if (widget.word.isNotEmpty) {
      for (int i = 0; i < widget.word.length; i++) {
        row.add(Cell(letter: widget.word[i]));
      }
      return row;
    } else {
      for (int i = 0; i < widget.wordSize; i++) {
        row.add(Cell(
          letter: Letter(letter: " ", status: LetterStatus.noStatus),
        ));
      }
    }
    return row;
  }

  void _updateInputRow() {
    List<Cell> row = [];

    guess = controller?.text ?? "";

    for (int i = 0; i < guess.length; i++) {
      row.add(Cell(
          letter: Letter(letter: guess[i], status: LetterStatus.noStatus)));
    }

    for (int i = 0; i < widget.wordSize - guess.length; i++) {
      row.add(Cell(letter: Letter(letter: " ", status: LetterStatus.noStatus)));
    }

    inputRow = row;
  }

  void _handleGuess() {
    (widget.handleGuess as Function(String))(guess);
  }

  List<Widget> _inputRow() {
    // return Column(
    //   children: [
    //     Row(children: inputRow),
    //     Container(
    //         height: 30,
    //         width: 240,
    //         child: TextField(
    //             autofocus: true,
    //             focusNode: focusNode,
    //             controller: controller,
    //             textCapitalization: TextCapitalization.characters,
    //             style: const TextStyle(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.w100,
    //                 color: Colors.black54),
    //             textAlign: TextAlign.center,
    //             onChanged: (String text) {
    //               print(text);
    //               // _updateInputRow();
    //             },
    //             inputFormatters: [
    //               LengthLimitingTextInputFormatter(5),
    //               UpperCaseTextFormatter(),
    //               FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
    //             ],
    //             onEditingComplete: () {}))
    //   ],
    // );
    // onChanged: widget.onChanged,

    return [
      Expanded(
          // height: 24,
          child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        inputFormatters: [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(5),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
        ],
        onSubmitted: (str) =>
            (widget.handleGuess as Function(String))(str.toUpperCase()),
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      controller = TextEditingController();
      focusNode = FocusNode();
      FocusScope.of(context).requestFocus(focusNode);
    }

    print(
        "Drawing current row and I'm ${widget.isActive ? "" : "not "} active...");
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.isActive ? _inputRow() : _rowBuilder(),
        ));
  }
}
