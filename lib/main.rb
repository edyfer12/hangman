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
    @guesser_word = Array.new(mystery_word.length - 1, "_")
    #Assign parameter of Game class to the mystery_word instance variable. The parameter is a 
    #random value picked from the restricted_words array. When loading the game after saving the
    #previous game, the value of the mystery_word will not be lost when player continues the guessing
    #the letter.
    @mystery_word = mystery_word.strip
    #Set the instance variable incorrect_inputs as an empty array. The array will store in the incorrect
    #guesses selected by the human player during the game.
    @incorrect_inputs = []
    #Display the instructions for the human player on how to play Hangman
    puts "\n------------------------WELCOME TO HANGMAN------------------"
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
    puts "                          TUTORIAL:"
    puts
    puts "Hangman is a word guessing game where you have to guess a letter"
    puts "provided by the computer that randomly selects a mystery"
    puts "word."    
    puts
    puts "Maximum number of incorrect guesses: 10"
    puts
    puts "Incorrect guesses would be:"
    puts
    puts "- Letter selected does not exist in the mystery word"
    puts "- Same correct letter has been chosen more than once"
    puts "- At least two letters entered other than 'save'"
    puts
    puts "Special Features included:"
    puts "- Save game during gameplay"
    puts "- Load game if previous game saved"
    puts 
    puts "You lose if there are no incorrect guesses left"
    puts "You win when all the letters guessed match with mystery word"
    puts
  end
  #Create an instance method called start_game where the human is at the stage of challenging against
  #the computer 
  def play_game 
    #Add a private method that requests the user to play the game
    request_game
    #Create variable called play_option and store the input from user
    play_option = gets.chomp.strip.downcase
    #Loop repeatedly until the user presses 'n', 'y' or 'l'
    until play_option == 'n' || play_option == 'y' || play_option == 'l'
      #If n is entered in play_option variable, close the program
      if play_option == 'n'
        exit
      #If l is entered in play_option variable, load the object from the hangman_save.json file
      #If an input is entered other than n, y or l, then print to user the same message if they want to start game
      elsif play_option != 'n' || play_option != 'y' || play_option != 'l'
        request_game
        #Add a new input from user to see if they want to play, load or cancel game
        play_option = gets.chomp.strip.downcase
      end
    end
    #Add whitespace
    puts
    #Print out Let's Play Hangman!
    puts "Let's Play Hangman!"
    #Display the guesser word to indicate the start of the game
    puts guesser_word.join(' ')
    #Print out incorrect guesses left
    puts "\nIncorrect guesses left: #{@incorrect_guesses_left}"
    #Add whitespace
    puts
    #If y is entered in play_option variable, enable the human player to guess a letter
    #in the mystery word provided by the computer that is acting like a game host using a while loop
      #Print out "Please guess a letter or type 'save' to save the game: "
      print "Please guess a letter or type 'save' to save the game: "
      #Declare variable called player_response and store input that is a letter or 'save' into memory
      player_response = gets.chomp.strip.downcase
      #Check if the letter is included in the mystery word
      #If letter is included, 
        #Set index to 0 and loop through the each character of the mystery word from first index to
        #last index. 
          #Inside the loop, if the index of the letter in guesser word match with element's position in
          #mystery word array then replace the underscore character in guesser word with the letter
          #Increment index by 1
      #If letter is not included in the mystery word or word is entered other than 'save',
        #Store the invalid input in incorrect_inputs array
        #Decrement the incorrect_guess_count by 1
      #If letter inputted is included in the guesser_word other than underscoree character
      #If user inputs 'save',
        #serialize the Game object containing properties such as incorrect_guess_count,
        #incorrect_guess_count, incorrect_inputs, guesser_word and mystery_word that is then progressed into a file
        #called, hangman_save.json
      #Print the updated guesser_word array
      #Print out incorrect_guesses_left
      #Print out incorrect_inputs array if the array is not empty
    #After exiting the loop, display the results to the player if they have won or lost
    #If there are no incorrect_guesses_left, print 'You lost the game!'
    #If the elements of guesser_word array matches with mystery_word, print 'You won the game!'
  end
  private
  #Create a private instance method called request_game that displays whether to play,
  #load or cancel game
  def request_game
    #If the hangman_save.json file does not exist, print out "Do you want to start new game (y/n)?"
    if File.exist? 'hangman_save.json'
      puts 'Do you want to start new game(y/n) or load(l)?'   
    #Otherwise, print out "Do you want to start new game(y/n) or load(l)?" 
    else
      puts "Do you want to start new game(y/n)?"
    end
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
Game.new(restricted_words.sample).play_game