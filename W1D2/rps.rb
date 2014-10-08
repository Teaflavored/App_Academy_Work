class RPS
  
  attr_reader :choices
  
  def initialize
    @choices = ["rock", "scissors", "paper"]
  end
  
  
  def get_input
    loop do
      print "What do you throw? "
      user_input = gets.chomp
      return user_input.downcase if choices.include?(user_input.downcase) 
      puts "Not a valid choice. Type better."
    end
  end
  
  def get_computer_choice
    choices[rand(3)]
  end
  
  def result(user_choice, computer_choice)
    return "Tie" if user_choice == computer_choice
    case user_choice
    when "rock"
      computer_choice == "paper" ? "Lose" : "Win"
    when "paper"
      computer_choice == "scissors" ? "Lose" : "Win"
    when "scissors"
      computer_choice == "rock" ? "Lose" : "Win"
    end
  end
  
  def rps
    comp_choice = get_computer_choice
    result = result(get_input, comp_choice)
    puts "#{comp_choice}, #{result}"
    
  end
  
end






