
require 'debugger'


class Board
  attr_accessor :board, :winning_combs
  def initialize
    @board = Array.new(3) { Array.new(3) { " " } }
    @winning_combs = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], 
                      [3, 5, 7], [1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end
  
  def render 
    @board.each do |row|
      row.each do |el|
        print "[#{el}]"
      end
      puts
    end
  end
  
  def full?
    (1..9).all? do |i|
      !empty?(i)
    end
  end


  def winner
    winning_combs.any? do |combination|
      return "x" if combination.all? do |spot|
        mark_at(spot) == "x"
      end
      return "o" if combination.all? do |spot|
          mark_at(spot) == "o"
      end
    end
    
    nil
  end
  
  def check_win_if_place_mark(num,mark)
    place_mark(num,mark)
    if won?
      delete_mark(num)
      true
    else
      delete_mark(num)
      false
    end
  end
  
  def won?
    winner
  end
  
  def mark_at(num)
    row, col = number_to_coordinate(num)
    @board[row][col]
  end
  
  def empty?(num)
    row, col = number_to_coordinate(num)
    @board[row][col] == " "
  end
  
  def delete_mark(num)
    row, col = number_to_coordinate(num)
    @board[row][col] = " "
  end
  
  def place_mark(num, mark)
    row, col = number_to_coordinate(num)
    @board[row][col] = mark
  end
  
  def coordinate_to_number(pos)
    row, col = pos
    row * 3 + col + 1
  end
  
  def number_to_coordinate(num)
    row = (num - 1) / 3
    col = (num - 1) % 3
    [row, col]
  end
  
  
end


class Game
  
  attr_accessor :board
  
  def initialize(player1,player2)
    @player1 = player1
    @player1.piece = 'x'
    @player2 = player2
    @player2.piece = 'o'
    @active_player = @player1

  end
  
  def reinitialize
    @board = Board.new
    @possible_moves = (1..9).to_a
    @active_player = @player1
  end
  
  def ai_helper
    winning_moves = []
    switch
    @possible_moves.each do |move|
      winning_moves << move if board.check_win_if_place_mark(move, @active_player.piece)
    end
    @active_player.get_winning_moves(winning_moves) if @active_player.is_a?(ComputerPlayer)
    switch
  end
  
  def play
    
    reinitialize
    puts "Welcome to our Tic-Tac-Toe!"
    users_choice = @active_player.user_input
    until board.full?
      users_choice = @active_player.user_input until board.empty?(users_choice)
      board.place_mark(users_choice, @active_player.piece)
      @possible_moves.delete(users_choice)
      ai_helper
      board.render
      if board.won?
        puts "Congratulations #{@active_player.username}, You've won"
        return 
      end
      switch
    end
    
    
    
    puts "Its a tie!"
  end
  
  def switch
    @active_player == @player1 ? 
                      @active_player = @player2 : @active_player = @player1
  end
  
  
end

class Player
  attr_accessor :piece, :username
  
  def initialize(username = 'Computer')
    @username = username
    @piece = nil
    @winning_moves = []
  end
  
  def render_guide
    puts %q(
      [1][2][3]
      [4][5][6]
      [7][8][9]
    )
  end
  
  def user_input
    loop do 
      render_guide
      puts "#{username}, where do you want to put your piece? it's #{@piece}"
      input = gets.chomp.to_i
      return input if input.between?(1,9)
      puts "Please enter a number between 1-9"
      render_guide
    end
  end    
end

class HumanPlayer < Player
  
end

class ComputerPlayer < Player
  
  def get_winning_moves(arr)
    @winning_moves = arr
  end
  
  def get_rand_move
    rand(9)+1
  end
  
  
  
  def user_input 
    if @winning_moves.empty?
      get_rand_move
    else
      @winning_moves.pop
    end
  end
end

auster = HumanPlayer.new("Auster")
aaron = HumanPlayer.new("Aaron")
comp = ComputerPlayer.new
game = Game.new(auster,comp)
game.play