require_relative 'knight.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require 'debugger'

class NoPieceError < StandardError
end
class NotYourPieceError < StandardError
end
  
class Board
  attr_reader :grid
  
  def initialize(dup = false)
    @grid = Array.new(8) { Array.new(8) { nil } }
    place_pieces_on_board unless dup
  end
  
  def display_board
    alphabet = ("A".."Z").to_a.take(8)
    puts "#{(alphabet.join "|")}|"
    
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if el.nil?
          print " |"
        else
          print "#{el.piece_unicode}|"
        end
      end
      puts row_index
    end
  end
  
  def in_check?(color)
    king_pos = find_king_position(color)
    enemy_possible_moves = []
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if !el.nil? && el.color != color
          enemy_possible_moves += el.possible_valid_moves
        end
      end
    end
    
    enemy_possible_moves.include?(king_pos)
  end
 
  
  def move_piece(start_pos, end_pos) #need to add more stuff
    start_piece = self[start_pos]
    self[end_pos] = start_piece
    self[start_pos] = nil
    start_piece.set_new_current_position(end_pos)
    if start_piece.is_a?(Pawn)
        start_piece.take_first_move
    end
    self
  end
  
  def valid_move?(start_pos, end_pos, color)
    start_piece = self[start_pos]
    if start_piece.nil?
      raise NoPieceError.new "There is no piece here!"
    elsif start_piece.color != color
      raise NotYourPieceError.new "That's not your piece."
    end
    if start_piece.possible_valid_moves.include?(end_pos)
      if start_piece.move_into_check?(end_pos)
        return false
      else
        return true
      end
    end
  end
  
  
  def place_pieces_on_board
    @grid.each_with_index do |row, row_index|
      row.each_index do |col_index|
        if row_index == 6
          @grid[row_index][col_index] = Pawn.new([row_index,col_index], self, :white)
        elsif row_index == 1
          @grid[row_index][col_index] = Pawn.new([row_index,col_index], self, :black)
        elsif row_index == 0
          if col_index == 0 || col_index == 7
            @grid[row_index][col_index] = Rook.new([row_index,col_index], self, :black)
          elsif col_index == 1 || col_index == 6
            @grid[row_index][col_index] = Knight.new([row_index,col_index], self, :black)
          elsif col_index == 2 || col_index == 5
            @grid[row_index][col_index] = Bishop.new([row_index,col_index], self, :black)
          elsif col_index == 3
            @grid[row_index][col_index] = Queen.new([row_index,col_index], self, :black)
          else
            @grid[row_index][col_index] = King.new([row_index,col_index], self, :black)
          end
        elsif row_index == 7
          if col_index == 0 || col_index == 7
            @grid[row_index][col_index] = Rook.new([row_index,col_index], self, :white)
          elsif col_index == 1 || col_index == 6
            @grid[row_index][col_index] = Knight.new([row_index,col_index], self, :white)
          elsif col_index == 2 || col_index == 5
            @grid[row_index][col_index] = Bishop.new([row_index,col_index], self, :white)
          elsif col_index == 3
            @grid[row_index][col_index] = Queen.new([row_index,col_index], self, :white)
          else
            @grid[row_index][col_index] = King.new([row_index,col_index], self, :white)
          end
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end
  
  def check_mate?(color)
    #player's color
    your_possible_moves = []
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if !el.nil? && el.color == color
          subanswer = el.possible_valid_moves
          subanswer.select! do |move|
            !el.move_into_check?(move)
          end
          your_possible_moves += subanswer
        end
      end
    end
    
   your_possible_moves.empty?
  end
  
  
  def dup
    #returns duplicated board
    new_board = self.class.new(true)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if !el.nil?
          new_board[[row_index, col_index]] = 
                      el.class.new([row_index, col_index], new_board, el.color)
          if el.is_a?(Pawn)
            new_board[[row_index, col_index]].take_first_move if el.move_taken
          end 
        end
      end
    end
    
    new_board
  end
  
  private
  
  def find_king_position(color)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if el.is_a?(King) && el.color == color
          return [row_index, col_index]
        end
      end
    end
    
  end
  
end