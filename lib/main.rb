#Include the contents of json.rb
require 'json'
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
    #Create variable called loaded that indicates if game is loaded or not
    loaded = false
    #Add a private method that requests the user to play the game
    request_game(loaded)
    #Create variable called play_option and store the input from user
    play_option = nil
    #Loop repeatedly until the user presses 'n' or 'y'
    until play_option == 'n' || play_option == 'y' 
      play_option = gets.chomp.strip.downcase
      #If n is entered in play_option variable, close the program
      if play_option == 'n'
        exit 
      #If y is entered in play_option variable, the player has to guess the letters to unravel
      #the mystery word
      elsif play_option == 'y'
        #Add method call to reveal the mystery word
        uncover_mystery_word
        #Delete the file once the game is finished
        if File.exist? 'hangman_save.json'
          f = File.new('hangman_save.json')
          File.delete(f)
        end
      #If l is entered in play_option variable, load the object from the hangman_save.json file
      elsif play_option == 'l'
        #Only enable the user to press 'l' if hangman_save.json exists
        if File.exist? 'hangman_save.json'
          #Create a file object that points to hangman_save.json
          f = File.new('hangman_save.json')
          #Load the serialized Game object from hangman_save.json file
          loaded_file = JSON::load(f)
          #Set each property of the Game object to value from the loaded file
          @incorrect_guesses_left = loaded_file['incorrect_guesses_left']
          @mystery_word = loaded_file['mystery_word']
          @guesser_word = loaded_file['guesser_word']
          @incorrect_inputs = loaded_file['incorrect_inputs']
        end
        #Set loaded to true
        loaded = true
        #Display request message
        request_game(loaded)
      #If an input is entered other than n, y or l, then print to user the same message if they want to start game
      elsif play_option != 'n' || play_option != 'y' || play_option != 'l'
        request_game(loaded)
        #Add a new input from user to see if they want to play, load or cancel game
        play_option = gets.chomp.strip.downcase
        #If user presses 'y', 
        if play_option == 'y'
          #Guess the letters to reveal the mystery_word using method call
          uncover_mystery_word
          #Delete the file once the game is finished
          if File.exist? 'hangman_save.json'
            f = File.new('hangman_save.json')
            File.delete(f)
          end
        end
        #Print out to enter options on whether to start new game, load or cancel game
        request_game(loaded)
      end
    end
  end
  private
  #Create a private instance method called request_game that displays whether to play,
  #load or cancel game
  def request_game(loaded)
    #Otherwise, print out "Do you want to start new game(y/n) or load(l)?" 
    if loaded == true || !(File.exist?'hangman_save.json')
      puts "Do you want to start new game(y/n)?"
    #If the hangman_save.json file does not exist, print out "Do you want to start new game (y/n)?"
    elsif File.exist?('hangman_save.json') && loaded == false
      puts 'Do you want to start new game(y/n) or load(l)?'   
    end
  end
  #Create a private instance method called uncover_mystery_word such that the player guesses a letter for the 
  #mystery_word until there are zero incorrect guesses left or figures out the mystery word
  def uncover_mystery_word
     #Add whitespace
     puts
     #Print out Let's Play Hangman!
     puts "Let's Play Hangman!"
     #Display the guesser word to indicate the start of the game
     puts guesser_word.join(' ')
     #If game is loaded, print out incorrect inputs and incorrect guesses
     puts "\nIncorrect guesses left: #{@incorrect_guesses_left}"
     puts "Incorrect guesses: #{@incorrect_inputs.uniq.join(', ').to_s}" if !@incorrect_inputs.empty?
     #Add whitespace
     puts
     #If y is entered in play_option variable, enable the human player to guess a letter
     #in the mystery word provided by the computer that is acting like a game host using a while loop
     while @incorrect_guesses_left > 0 && @guesser_word.join('') != @mystery_word
       #Print out "Please guess a letter or type 'save' to save the game: "
       print "Please guess a letter or type 'save' to save the game: "
       #Declare variable called player_response and store input that is a letter or 'save' into memory
       player_response = gets.chomp.strip.downcase
       #If user inputs 'save',
       if player_response == 'save'
         #serialize the Game object containing properties such as incorrect_guess_count,
         #incorrect_guess_count, incorrect_inputs, guesser_word and mystery_word that is then progressed into a file
         #called, hangman_save.json
         saved_game = JSON.dump(
          :incorrect_guesses_left => @incorrect_guesses_left,
          :incorrect_inputs => @incorrect_inputs,
          :guesser_word => @guesser_word,
          :mystery_word => @mystery_word
          )
          file = File.open('hangman_save.json', 'w')
          file.puts saved_game
          file.close
       #If letter is not included in the mystery word or word is entered other than 'save',
       elsif (player_response != 'save' && player_response.length > 1) || !(@mystery_word.include?(player_response) && player_response != 'save') || player_response == ""
         #Store the invalid input in incorrect_inputs array
         @incorrect_inputs << player_response if player_response != ""
         #Decrement the incorrect_guess_count by 1
         @incorrect_guesses_left -= 1
       #If letter inputted is included in the guesser_word other than underscoree character
       elsif @guesser_word.include? player_response
         @incorrect_guesses_left -= 1
       #Check if the letter is included in the mystery word
       #If letter is included, 
       elsif @mystery_word.include? player_response
         #Set index to 0 and loop through the each character of the mystery word from first index to
         #last index. 
         index = 0
         while index < @mystery_word.length
           #Inside the loop, if the input match with element's position in mystery word array then 
           #replace the underscore character in guesser word with the letter
           if player_response == @mystery_word[index]
             @guesser_word[index] = @mystery_word[index]
           end
           #Increment index by 1
           index += 1
         end
        end
       #Add empty line to make program presentable
       puts
       #Print the updated guesser_word array
       puts @guesser_word.join(' ')
       #Display an empty line to enable the program to appear presentable
       puts
       #Print out incorrect_guesses_left
       puts "Incorrect guesses left: #{@incorrect_guesses_left}"
       #Print out incorrect_inputs array if the array is not empty
       puts "Incorrect guesses: #{@incorrect_inputs.uniq.join(', ').to_s}" if !@incorrect_inputs.empty?
       #Add empty line to make program look 
       puts
      end
     #After exiting the loop, use the instance method to show the results
     show_results
    end
  end
  #Create a private instance method called show_results where the results are revealed to the player
  #if they won or lost the game of Hangman
  def show_results
    #If the incorrect_guesses_left is 0, print on the console 'You have lost the game! Thanks for playing'
    if @incorrect_guesses_left == 0
      puts "You have lost the game! Thanks for playing"
      puts "Mystery word was #{@mystery_word}"
    #If the mystery word is equal to the guesser word, print on the console 'You have won the game! Thanks for playing'
    elsif @mystery_word == @guesser_word.join('')
      puts "You have won the game! Thanks for playing"
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