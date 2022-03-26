# nerdle

A wordle-inspired app for mobile phones developed with Flutter.

## in development

Basic gameplay is working with my limited list of five-letter words in a .txt file.  Need to work on following improvements:
- input line is currently a basic textfield. Would like to have it appear as row of five empty blocks, and as user types, a letter appears in a cell and the cursor move to the next, with ability to go backwards (and delete letters) with backspace key. Have tried a few methods from StackOverflow but none work without issue yet.
- The current system of scoring the current guess (e.g., green for letters in correct position, blue for letter that is in the word but not in the right place), is not sophisticated enough. It needs to let you know if you've used a letter too many times, or multiple overlapping issues (e.g., you have one 'e' in the correct place, and there is another 'e' but you've got it in the wrong place)
- Need to find a resource for a larger library of 5-letter words, and have better i/o to load words in.
- Need to improve layout so that you can see more of the board when the soft keyboard appears.
- Better-looking dialog boxes when game is over (either success or run out of guesses)
- Customize soft keyboard to highlight letters that have already been guesses and are not in the word
- Don't allow submission of words with "illegal" letters, or words that are not in my library
- Possibly some basic instructions or information at top or botom of screen