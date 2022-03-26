// enum used for status of a letter that has been added to board model
enum LetterStatus { correct, incorrect, inWrongPlace, noStatus }

// class for letters in order to store their status along with the letter
class Letter {
  final String letter;
  final LetterStatus status;

  Letter({required this.letter, required this.status});
}
