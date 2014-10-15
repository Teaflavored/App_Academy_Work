require_relative 'board.rb'
class Game
  
  ALPHABET = ("a".."h").to_a
  
  def initialize
    @board = Board.new
    @current_turn = :white
  end
  
  def start_game
    system("clear")
    puts "Welcome to Chess!"
    @board.display_board
    until @board.check_mate?(:white) || @board.check_mate?(:black)
      puts "It's #{@current_turn}'s turn"
      begin
        input = get_user_input
        move_choice = parse_user_input(input)
        if @board.valid_move?(move_choice.first, move_choice.last, @current_turn)
          @board.move_piece(move_choice.first, move_choice.last)
          switch_turn
          system("clear")
          @board.display_board
        else
          system("clear")
          puts "not a valid move, please try again"
          @board.display_board
        end
      rescue  NoPieceError => e
        puts e.message
        retry
        
      rescue NotYourPieceError => e
        puts e.message
        retry
        
      end
    end
    switch_turn
    puts "#{@current_turn} wins!"
  end
  
  def get_user_input
    puts "What piece would you like to move?"
    input_1 = gets.chomp
    puts "Where would you like to move to?"
    input_2 = gets.chomp
    [input_1, input_2]
  end
  
  def parse_user_input(array)
    from, to = array
    from_arr = from.split("")
    from_col = ALPHABET.index(from_arr.first.downcase)
    from_row = from_arr.last.to_i
    
    to_arr = to.split("")
    to_col = ALPHABET.index(to_arr.first.downcase)
    to_row = to_arr.last.to_i
    
    [[from_row, from_col],[to_row, to_col]]
  end
  
  def valid_input?(row, col)
    raise NOTONBOARD unless row.between?(0, 7) && col.between?(0, 7)
    
    true
  end
  
  def switch_turn
    @current_turn = @current_turn == :white ? :black : :white
  end
  
end

game = Game.new
game.start_game