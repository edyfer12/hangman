#Create a Game class that is used to enable both the computer and human to challenge
#each other in the game of Hangman. The computer will act as a host to nominate the mystery
#word and hide the word from the user to guess the letter. The instance variables for the 
#Game class will be the incorrect_guesses_left, guesser_word, mystery_word and incorrect_inputs

#Create variable called dictionary to store all the contents from the file called
#google-10000-english-no-swears.txt line by line and return as an array into memory.
#This will be used by the computer to pick out the random word for the guesser to select
#the letter for the mystery word.

dictionary = File.readlines('../google-10000-english-no-swears.txt')

#Create a variable called mystery_word. The mystery_word will consist of a randomly 
#chosen word from the dictionary array that has between 5 and 12 characters which is one
#of the rules created for the host(or computer) of the game.

restricted_words = dictionary.filter do |word|
  if word.strip.length >= 5 && word.strip.length <= 12
    word
  end
end