import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_cell.dart';
import 'models/logical_board.dart';

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
  final WordModel word;
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

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      controller = TextEditingController();
      focusNode = FocusNode();
      // FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isActive) {
      controller?.dispose();
      focusNode?.dispose();
    }
  }

  void _handleSubmit(String str) {
    print("Final submission: ${str}");
  }

  List<Cell> _rowBuilder() {
    List<Cell> row = [];

    // if row has already been guessed, produce row with word in it:
    if (widget.word.isNotEmpty) {
      for (int i = 0; i < widget.word.length; i++) {
        row.add(Cell(cell: widget.word[i]));
      }
      return row;
    } else {
      for (int i = 0; i < widget.wordSize; i++) {
        row.add(Cell(
          cell: LogicalCell(letter: " ", status: CellStatus.noStatus),
          isActive: false,
        ));
      }
    }

    return row;
  }

  Widget _inputRow() {
    return Container(
        height: 50,
        width: 240,
        child: TextField(
          autofocus: true,
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 36, fontWeight: FontWeight.w700, color: Colors.black87),
          // keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
          onSubmitted: widget.handleGuess,
        ));
    // onChanged: widget.onChanged,
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.isActive ? [_inputRow()] : _rowBuilder(),
        ));
  }
}
