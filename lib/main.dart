import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import './game_board.dart';

const int WORDSIZE = 5;
const int NUMGUESSES = 5;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerdle',
      theme: ThemeData(
          primaryColor: Colors.orange.shade300,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.orange.shade300,
              secondary: Colors.blueGrey.shade300)),
      home: const MyHomePage(title: 'nerdle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GameBoard(
        numGuesses: NUMGUESSES,
        wordSize: WORDSIZE,
      ),
    );
  }
}
