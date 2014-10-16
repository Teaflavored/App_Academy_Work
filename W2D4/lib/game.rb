require_relative 'board.rb'
require 'io/console'
require 'yaml'

class Game
  
  def initialize
    @board = Board.new
    @current = :white
  end
  
  def start_game
    system("clear")
    puts "Would you like to load a previous game? (y/n)"
    input = gets.chomp
    if input == 'y'
      fail "No save game yet" unless File.exist?("saved-game.txt")
      load_game("saved-game.txt").run
    else
      run
    end
    
    nil
  end
  
  def alternate_input
    move_seq = []
    loop do
      input = $stdin.getch
      case input
      when 'w'
        @board.update_current_tile(:up)
        display
      when 's'
        @board.update_current_tile(:down)
        display
      when 'a'
        @board.update_current_tile(:left)
        display
      when 'd'
        @board.update_current_tile(:right)
        display
      when 'f'
        move_seq << @board.current
        p move_seq
      when 'l'
        move_seq = []
        display
      when 'r'
        raise InvalidMoveError if move_seq.empty? || move_seq.size == 1
        raise NoPieceThere.new if @board[move_seq[0]].nil?
        return move_seq
      when '0'
        exit
      when 'p'
        save_game
      end
    end
  end
  
  def display
    system("clear")
    @board.render
  end
  
  def run
    system("clear")
    @board.render
    until @board.over?
      begin 
        input = alternate_input
        handle_full_turn(input)
        
      rescue CanJumpMustJump
        puts "That's not valid since you still have moves left."
        retry
      rescue InvalidMoveError
        puts "Cannot make that move."
        retry
      rescue NotYourPiece
        puts "That piece does not belong to you."
        retry
      rescue NoPieceThere
        puts "There's no piece at starting position."
        retry
      end
    end
    
    puts "Winner is #{@board.winner}"
  end
  
  private 
   
  def load_game(filename)
    yaml_str = File.read(filename)
    YAML.load(yaml_str)
  end
  
  def save_game
    File.open("saved-game.txt", "w") do |f|
      f.puts self.to_yaml
    end
    puts "Successfully saved!"
    exit
  end
  
  def handle_full_turn(input)
    @board[input[0]].perform_moves(input.drop(1), @current)
    system("clear")
    @board.switch_turn
    @board.render
    switch_turn
  end
  
  def switch_turn
    @current = @current == :white ? :red : :white
  end
  
  def get_user_input
    loop do
      puts "Enter a sequence of moves from starting piece (e.g. 5,0;4,1), (Enter s to save)."
      input = gets.chomp
      save_game if input == 's'
      return input if input.match(/\A[0-7]{1},[0-7]{1}(;[0-7]{1},[0-7]{1})+\z/)
      puts "Invalid input, piece positions must be given in \"row,col\";\"row,col\" from start to end."
     end 
  end
  
  def parse_user_input(input)
    result = []
    input.split(";").each do |coord|
      result << coord.split(",").map(&:to_i)
    end
    raise NoPieceThere.new if @board[result[0]].nil?
    
    result
  end
  
end

game = Game.new
game.start_game