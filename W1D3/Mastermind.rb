class Code
  attr_reader :array_of_code

  def initialize(arr)
    @array_of_code = arr
  end
  
  def check_exact_match(test_code)
    #returns integer of exact matches
    matches = 0
    self.array_of_code.each_index do |index|
      matches += 1 if self.array_of_code[index] == test_code[index]
    end
    
    matches
  end
  
  def check_common_matches_helper(test_code)
    copy_of_self = self.array_of_code.dup
    matches = 0
    test_code.each do |el|
      copy_of_self.each_with_index do |el2, index|
      if el == el2
        matches +=1
        copy_of_self.delete_at(index)
        next
      end
    end
  end
    
    matches
  end
  
  def check_near_match(test_code)
    #returns integer of near matches
    exact_matches = check_exact_match(test_code)
    common_matches = check_common_matches_helper(test_code)
    common_matches - exact_matches
  end
  
  
  def self.create_random_code
    #this sets the answer code
    shuffled_pegs = []
    4.times do
      shuffled_pegs << %w(R G B Y O P).shuffle.last
    end
    
    Code.new(shuffled_pegs)
  end

end

class Game
  
  def initialize
    @guesses_remaining = 10
    @comp_code = Code.create_random_code
    @user_code = nil
    @valid_choices = %w(R G B Y O P)
  end
  
  def out_of_guesses?
    @guesses_remaining == 0
  end
  
  def game_over?
    out_of_guesses? || solved? 
  end
  
  def solved?
    return false if @comp_code.nil? || @user_code.nil?
    @comp_code.array_of_code == @user_code.array_of_code 
  end
  
  def valid_guess?(guess)
    guess.all? { |g| @valid_choices.include?(g) }
  end
  
  def user_input
    loop do
      puts "What's your guess? You have #{@guesses_remaining} guesses remaining"
      guess = gets.chomp.upcase.split("")
      p guess
      return guess if guess.size == 4 && valid_guess?(guess)
      puts "Not a valid guess.  Try again."
    end
  end
  
  def count_down_guess
    @guesses_remaining -= 1
  end
  
  def give_feedback(test_code) 
    exact_number = @comp_code.check_exact_match(test_code.array_of_code)
    near_number = @comp_code.check_near_match(test_code.array_of_code)
    puts "You have #{exact_number} exact matches and #{near_number} near matches."
  end
  
  def play
    puts "Welcome to Mastermind!  Choices are #{ @valid_choices.join }"
    p @comp_code.array_of_code
    until game_over?
      @user_code = Code.new(user_input)
      give_feedback(@user_code)
      count_down_guess
    end
    
    out_of_guesses? ? (puts "You lose, you're out of guesses, the answer was #{@comp_code.array_of_code}") : (puts "Congrats, you've solved the code in #{10-@guesses_remaining} guesses")
    
  end
  
end


game = Game.new
game.play