// enum used for status of a letter that has been added to board model
enum CellStatus { correct, incorrect, inWrongPlace, noStatus }

// class for letters in order to store their status along with the letter
class LogicalCell {
  final String letter;
  final CellStatus status;

  LogicalCell({required this.letter, required this.status});

  String get statusString {
    Map<CellStatus, String> CellStatusMap = {
      CellStatus.correct: "correct",
      CellStatus.incorrect: "incorrect",
      CellStatus.inWrongPlace: "inWrongPlace",
      CellStatus.noStatus: "noStatus",
    };

    if (CellStatusMap.containsKey(status)) {
      return CellStatusMap[status] as String;
    } else
      return "not found";
  }
}

typedef WordModel = List<LogicalCell>;

class InvalidGuessException implements Exception {
  String errMsg() =>
      'Length of provided guess was invalid. Must be same length as target word.';
}

class LogicalBoard {
  List<WordModel> rows = [];
  String targetWord;
  bool guessed = false;

  LogicalBoard(this.targetWord);

  void _addRow(WordModel row) {
    rows.add(row);
  }

  void addGuess(String guess) {
    WordModel row = [];
    if (guess.length != targetWord.length) {
      throw InvalidGuessException();
    }

    int numCorrect = 0;
    for (int i = 0; i < guess.length; i++) {
      String letter = guess[i];

      if (guess[i] == targetWord[i]) {
        row.add(LogicalCell(letter: letter, status: CellStatus.correct));
        numCorrect++;
        print("${letter} is correct! That is ${numCorrect} letters!");
        if (numCorrect == targetWord.length) {
          guessed = true;
          print("YOU GOT IT RIGHT! NICE WORK!");
        }
      } else if (targetWord.contains(letter)) {
        row.add(LogicalCell(letter: letter, status: CellStatus.inWrongPlace));
      } else {
        row.add(LogicalCell(letter: letter, status: CellStatus.incorrect));
      }
    }
    _addRow(row);
  }
}
