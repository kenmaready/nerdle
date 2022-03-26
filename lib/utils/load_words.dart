import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';

Future<List<String>> loadWords(String filePath) async {
  List<String> words = [];
  await rootBundle.loadString(filePath).then((w) {
    for (String i in const LineSplitter().convert(w)) {
      if (i.length == 5) {
        words.add(i.toUpperCase());
      }
    }
  }).catchError((err) => print(err));

  return words;
}
