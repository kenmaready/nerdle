import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
//
import 'word.dart';
import 'letter.dart';

class InvalidGuessException implements Exception {
  String errMsg() =>
      'Length of provided guess was invalid. Must be same length as target word.';
}

class Puzzle with ChangeNotifier {
  String targetWord;
  int? maxGuesses; // maxGuesses is optional parameter. If not provided,
  // the puzzle will allow as many guesses as there are
  // letters in the targetWord.

  List<Word> rows = [];
  bool success = false;
  bool fail = false;

  Puzzle({required this.targetWord, this.maxGuesses});

  // some useful getters
  int get wordSize => targetWord.length;
  int get guessesTaken => rows.length;
  int get guessesRemaining => (maxGuesses ?? targetWord.length) - guessesTaken;

  void _addRow(Word row) {
    rows.add(row);
  }

  void guess(String guess) {
    print("checking guess (${guess}) against targetWord of ${targetWord}");

    // check to make sure submitted guess is the currect length for this puzzle:
    if (guess.length != wordSize) {
      throw InvalidGuessException();
    }

    Word row = [];
    int numCorrectLetters = 0;

    for (int i = 0; i < wordSize; i++) {
      String currentLetter = guess[i];

      if (currentLetter == targetWord[i]) {
        row.add(Letter(letter: currentLetter, status: LetterStatus.correct));
        numCorrectLetters++;

        print(
            "${currentLetter} is correct! That is ${numCorrectLetters} letters!");

        // check to see if entire word is correct:
        if (numCorrectLetters == wordSize) {
          success = true;
          print("YOU GOT IT RIGHT! NICE WORK!");
        }
      } else if (targetWord.contains(currentLetter)) {
        // letter is in the target word, but not guessed in corredct place
        row.add(
            Letter(letter: currentLetter, status: LetterStatus.inWrongPlace));
      } else {
        // letter is not in the target word
        row.add(Letter(letter: currentLetter, status: LetterStatus.incorrect));
      }
    }

    // add this row of Letters to the puzzle guesses and return
    _addRow(row);

    // if there are no guesses remaining then toggle failure flag
    if (guessesRemaining <= 0 && !success) fail = true;

    notifyListeners();
  }
}
