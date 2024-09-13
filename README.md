# hangman

This project will be on Hangman game that is a word guessing game where a human plays against a computer.

The computer is a host that selects out the random word between 5 and 12 characters
hidden from the player which is displayed as a number of underscores equal to the number of characters for a word. 

Each round the player guesses a letter based on the mystery word. The player has a maximum of 10 incorrect guesses. If the letter chosen does not exist in the mystery word, correct letter was already chosen is selected, or more than one letter was typed
other than 'save', that guess will be made as incorrect from the user reducing the incorrect guess by one. The number of incorrect guesses left will be displayed to the user so they are able to determine the remaining number of chances to nominate the letter as instructed. Also, the incorrect inputs selected from the user will be outputted on the screen to guide the user on which characters or words have been selected already or not. If the number of incorrect guesses is down to zero, the player loses the game to the computer.

Before the game is played, there will be detailed instructions provided that will guide the user on how to play of Hangman. The player will be given the option to either
start new game (pressing 'y'), close the program (pressing 'n') or load existing game (pressing 'l' only if the user has saved previous game).

When the game is played, in addition to considering guessing features provided to the user, the save feature will be included into the program. The player will be able to save the game by typing in 'save' as opposed to choosing a letter to guess. When 'save' is typed as input, the data of incorrect guesses left, arrays for mystery word,guesser and incorrect input from user will be recorded into the external file called
'saved_file.json'. The mystery word array is an array that has a randomly chosen word that are split into individual characters. The array for the guesser consists of all the correct letters and underscores. The other array of incorrect inputs include letters that do not match the character in the mystery word array and words entered by the user. For this reason, if the player closes the game during gameplay, the user can load the game to continue playing as soon as they open the program again.