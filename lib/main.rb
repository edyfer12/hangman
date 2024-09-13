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
puts restricted_words