#Include the contents of json.rb
#Create a Game class that is used to enable both the computer and human to challenge
#each other in the game of Hangman. The computer will act as a host to nominate the mystery
#word and hide the word from the user to guess the letter. The instance variables for the 
#Game class will be the incorrect_guesses_left, guesser_word, mystery_word and incorrect_inputs
class Game  
  #Add accessor methods for incorrect_guesses_left, guesser_word and incorrect_inputs so those 
  #instance variables can be accessed and modified during the gameplay. Add mystery_word as a 
  #getter method as it is intended to be read-only.
  attr_accessor :incorrect_guesses_left, :guesser_word, :incorrect_inputs
  attr_reader :mystery_word
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
    #Display the instructions for the human player on how to play Hangman
    puts "\n            ---------------WELCOME TO HANGMAN------------------"
    puts
    puts "               =================================="
    puts "               ||                                |"
    puts "               ||                                |"
    puts "               ||                                |"
    puts "               ||                              __|__"
    puts "               ||                             |     |"
    puts "               ||                             |__ __|"
    puts "               ||                                |"
    puts "               ||                               /|\\"
    puts "               ||                              / | \\"
    puts "               ||                             /  |  \\"
    puts "               ||                                |    "
    puts "               ||                               / \\"
    puts "               ||                              /   \\"
    puts "               ||                             /     \\"
    puts "               ||"
    puts "               ||"
    puts "               ||"
    puts "               ||\\"
    puts "               || \\"
    puts "               =================================="
    puts
    puts "                                   TUTORIAL:"
    puts
    puts "        Hangman is a word guessing game where the human has to guess"
    puts "        a letter provided by the computer that randomly selects a mystery"
    puts "        word. The player has no more than 10 incorrect guesses. An"
    puts "        incorrect guess would be if the letter does not exist in the "
    puts "        mystery word, correct letter has been selected more than once,"
    puts "        or more than one letter has been entered other than 'save'. If"
    puts "        all the correct letters match the mystery word provided to the"
    puts "        player, then the game is won. When the player makes all 10"
    puts "        incorrect guesses, then the game is lost."
    puts
    puts "        Along with the feature to guess a letter, there is also an option"
    puts "        to save the game. During gameplay of Hangman, to save progress from"
    puts "        being lost for the guesser, just type and enter 'save'. The player"
    puts "        will have the option to load the game that was previously saved to" 
    puts "        continue challenging against the computer. To load the game, enter"
    puts "        'l' before gameplay."
    puts
  end
  #Create an instance method called start_game where the human is at the stage of challenging against
  #the computer 
  def start_game 
    #If the hangman_save.json file does not exist, print out "Do you want to start new game (y/n)?"
    if File.exist? 'hangman_save.json'
      puts 'Do you want to start new game(y/n) or load(l)?'   
    #Otherwise, print out "Do you want to start new game(y/n) or load(l)?" 
    else
      puts "Do you want to start new game(y/n)?"
    end
    #Create variable called play_option and store the input from user
    play_option = gets.chomp
    #If n is entered in play_option variable, close the program
    if play_option == 'n'
      exit
    #If y is entered in play_option variable, play the game against the computer
    #If l is entered in play_option variable, load the object from the hangman_save.json file
    #If an input is entered other than n, y or l, then print to user the same message if they want to start game
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

#Create a Game object to start the game of Hangman between computer and human
Game.new(restricted_words.sample).start_game