class Hangman
  def initialize(player1,player2)
    @picking_player = player1 #player who picks the word
    @guessing_player = player2 #player who tries to guess
  end
  
  def display
    puts "Secret word: #{ @guessing_player.current_state.join(" ") }"
  end
  
  def add_to_player_guesses(user_input)
    @guessing_player.guess_letter(user_input) 
  end
  
  def play
    puts "Welcome to Hangman!"
    @guessing_player.set_word_length( @picking_player.pick_word )
    
    until game_over?
      display
      begin
        temp_choice = @guessing_player.get_user_input
      rescue
        puts "Game will now exit now since you are cheating"
        exit
      end
      add_to_player_guesses(temp_choice)
      @picking_player.check_letter_and_position(temp_choice, @guessing_player)
      @guessing_player.update_current_state(@guessing_player)
    end
    
    @guessing_player.solved? ? (puts "Congrats #{ @guessing_player.name }, you've solved the word \"#{ @guessing_player.return_final_word }\" in #{15-@guessing_player.tries} guesses") : (puts "#{ @guessing_player.name }, you lose, you're out of guesses") 
  end

  def game_over?
    !@guessing_player.tries_left? || @guessing_player.solved?
  end
  
end

class Player
  attr_reader :name, :word, :guesses, :tries, :current_state, :word
  attr_accessor :correct_letters
  
  def initialize(name = "computer")
    @name = name
    @guesses = []
    @tries = 15
    @correct_letters = {}
  end
  
  def set_word_length(word_length)
    @current_state = Array.new(word_length) { "_" }
  end
  
  def solved?
    !@current_state.include?("_")
  end
  
  def tries_left?
    @tries > 0
  end
  
  #update the current state
  def update_current_state(player)
    player.correct_letters.each do |key, values|
      values.each do |index|
        player.current_state[index] = key
      end
    end
  end
  
  def count_down_tries
    @tries -= 1
  end
  
  def guess_letter(letter)
    @guesses << letter
  end
  
  def return_final_word
    "#{ @current_state.join("") }"
  end
  
  
end

class HumanPlayer < Player
  def get_user_input
    loop do
      puts "Guess a letter.  You have #{@tries} tries left."
      user_input = gets.chomp.downcase
      return user_input if okay_letter?(user_input)
      puts "Invalid letter #{user_input}.  Try again."
    end
  end
  
  def check_letter_and_position(letter,player)
    puts "Is #{letter} in your word? #{player.tries} tries left"
    player.count_down_tries
    selection = gets.chomp.downcase
    if selection == 'y'
      puts "Where are the positions"
      selection2 = gets.chomp.split(',').map(&:to_i)
      player.correct_letters[letter] = selection2
    end
  end
  
  def pick_word
    puts "What is the length of the word?"
    word_length = gets.chomp.to_i
  end
  
  private 
    def valid_input?(user_input)
      user_input.match(/[a-z]{1}/) && user_input.length == 1
    end

    def okay_letter?(user_input)
      return true if valid_input?(user_input) && !self.guesses.include?(user_input)
      nil
    end
end

class CompPlayer < Player
  
  class WordDoesNotExistError < StandardError
  end
  
  def initialize 
    super
    @dictionary = load_dictionary
    @word = pick_random_word_from_dictionary
  end
  
  def pick_word
    @word.length
  end
  
  def get_user_input
    update_smart_dictionary
    remove_words_that_contain_wrong_guessses
    raise WordDoesNotExistError if @smart_dictionary.empty?
    choice = most_frequent_letter
    choice
  end
  
  def update_smart_dictionary
    @smart_dictionary.select! do |word|
      word.split("").each_with_index.all? do |letter,idx|
        @current_state[idx] == letter || @current_state[idx] == "_"
      end
    end
  end
  
  def remove_words_that_contain_wrong_guessses
    wrong_guesses = @guesses - @current_state
    @smart_dictionary.reject! do |word|
      wrong_guesses.any? do |char|
        word.include?(char)
      end
    end
  end
  
  def most_frequent_letter
    long_string = @smart_dictionary.join('')
    counts = Hash.new(0)
    long_string.split("").each do |char|
      counts[char] += 1 unless @guesses.include?(char)
    end
    counts.max_by { |k, v| v }.first
  end
  
  def set_word_length(word_length)
    @current_state = Array.new(word_length) { "_" }
    filter_number_of_words(word_length)
  end
  
  def filter_number_of_words(word_length)
    @smart_dictionary = @dictionary.select{|word| word.length == word_length }
  end
  
  def check_letter_and_position(letter, player)
    player.count_down_tries
    indices = []
    
    @word.split("").each_with_index do |char, index|
        indices << index if char == letter
    end
    player.correct_letters[letter] = indices
  end
  
  def load_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end
  
  def pick_random_word_from_dictionary
    @dictionary.sample
  end
  
end

#enrapture
if __FILE__ == $PROGRAM_NAME
  puts "Who's picking the word? Computer? (Y/N)"
  user_selection = gets.chomp.downcase
  if user_selection == 'y'
    picker = CompPlayer.new
  else
    picker = HumanPlayer.new("Auster")
  end
  
  puts "Who's guessing the word? Computer? (Y/N)"
  user_selection = gets.chomp.downcase
  if user_selection == 'y'
    guesser = CompPlayer.new
  else
    guesser = HumanPlayer.new("Biyin")
  end
  
  game = Hangman.new(picker,guesser)
  game.play
end