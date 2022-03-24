import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String char;
  const Cell({Key? key, this.char = " "}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.lightGreen.shade300,
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(char,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)),
        ));
  }
}
