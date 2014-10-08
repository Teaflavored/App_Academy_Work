class GuessingGame
  attr_reader :computer_number
  attr_accessor :amount_of_guesses, :player_number
  def initialize 
    @amount_of_guesses = 0
    @computer_number = get_rand_num
    @player_number = nil
  end
  
  
  def get_rand_num
    rand(100) + 1
  end
  
  def user_input
    loop do 
      puts "Give me a number: "
      input = gets.chomp.to_i
      return input if input.between?(1,100)
    end
  end
  
  def over?
    player_number == computer_number
  end
  
  def play
    until over?
      self.player_number = user_input
      self.amount_of_guesses+=1
      p compare
    end
  end
  
  def compare
    if player_number > computer_number
      "Too High"
    elsif computer_number > player_number
      "Too Low"
    else
      "Win, #{amount_of_guesses} guesses"
    end
  end
  
end

test = GuessingGame.new
test.play