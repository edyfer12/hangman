#Create a Game class that is used to enable both the computer and human to challenge
#each other in the game of Hangman. The computer will act as a host to nominate the mystery
#word and hide the word from the user to guess the letter. The instance variables for the 
#Game class will be the incorrect_guesses_left, guesser_word, mystery_word and incorrect_inputs
class Game  
  #Add accessor methods for incorrect_guesses_left, guesser_word and incorrect_inputs so those 
  #instance variables can be accessed and modified during the gameplay. Add mystery_word as
  #a getter method to only read the mystery word.
  def initialize(mystery_word)
    #Set incorrect_guess_left to 10 as the human has a maximum of 10 incorrect guesses left
    #when nominating a letter for the mystery word provided
    @incorrect_guesses_left = 10
    #Set the guesser_word to a default length equal to mystery_word with value of underscore
    #This is to replace the underscore with a correct letter in the guesser_word array during 
    #gameplay.
    @guesser_word = Array.new(mystery_word.length, "_")
    #Assign parameter of Game class to the mystery_word instance variable. The parameter is a 
    #random value picked from the restricted_words array. When loading the game after saving the
    #previous game, the value of the mystery_word will not be lost when player continues the guessing
    #the letter.
    @mystery_word = mystery_word
    #Set the instance variable incorrect_inputs as an empty array. The array will store in the incorrect
    #guesses selected by the human player during the game.
    @incorrect_inputs = []
  end
end

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
puts Game.new(restricted_words.sample).guesser_word