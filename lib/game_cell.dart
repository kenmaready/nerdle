import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/logical_board.dart';

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

class CellColor {
  static Map<CellStatus, Color> colorMap = {
    CellStatus.noStatus: Colors.white,
    CellStatus.correct: Colors.lightGreen.shade300,
    CellStatus.inWrongPlace: Colors.lightBlue.shade100,
    CellStatus.incorrect: Colors.red.shade200,
  };
}

class Cell extends StatefulWidget {
  final LogicalCell cell;
  final bool isActive;
  FocusNode? focusNode;
  TextEditingController? controller;
  Function(String)? onChanged;

  Cell(
      {Key? key,
      required this.cell,
      this.isActive = false,
      FocusNode? this.focusNode,
      TextEditingController? this.controller,
      Function(String)? this.onChanged})
      : super(key: key);

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    Widget textArea = widget.isActive
        ? (TextField(
            autofocus: true,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
            // keyboardType: TextInputType.name,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
            onChanged: widget.onChanged,
          ))
        : (Text(widget.cell.letter,
            style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.black87)));

    return Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: CellColor.colorMap[widget.cell.status],
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: textArea,
        ));
  }
}
