# encoding: utf-8
require_relative 'piece.rb'

class Board
  attr_reader :current
  
  def initialize(dup = false)
    @grid = Array.new(8) { Array.new(8) { nil } }
    @current_turn = :white
    @current = [0,0]
    populate_grid unless dup
  end
  
  def over?
    pieces = @grid.flatten.compact
    [:white, :red].any? do |color|
      pieces.all? { |piece| piece.color == color }
    end
  end
  
  def winner
    @grid.flatten.compact.first.color
  end
  
  def switch_turn
    @current_turn = @current_turn == :white ? :red : :white
  end
  
  def render
    puts "Checkers! WASD to move around, F to path from start piece"
    puts "R at final destination to execute move sequence, P to save game, 0 to exit."
    puts "L to clear move sequence and redo from starting piece."
    puts "*Current turn is #{@current_turn}'s turn.*\n\n"
    puts "  #{(0..7).to_a.join(" ")}"
    each_pos do |el, row, col|
      print "#{row}|" if col == 0
      piece = el.nil? ? " |" : "#{el.symbol}|"
      print [row, col] == @current ? piece.on_yellow.blink : piece
      puts if col == 7
    end
  end
  
  def update_current_tile(sym)
    case sym
    when :left
      new_pos = [@current[0], @current[1] - 1]
    when :right
      new_pos = [@current[0], @current[1] + 1]
    when :up
      new_pos = [@current[0] - 1, @current[1]]
    when :down
      new_pos = [@current[0] + 1, @current[1]]
    end
    @current = new_pos if on_board?(new_pos)
  end
  
  def [](pos)
    #returns element at grid accessing by an array
    row, col = pos
    @grid[row][col]
  end
  
  def []=(pos, piece)
    #sets grid at pos to piece
    row, col = pos
    @grid[row][col] = piece
  end
  
  def on_board?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

  def dup
    new_board = Board.new(true)
    each_pos do |el, row, col|
      if !el.nil?
        new_board[[row, col]] = el.class.new([row, col], new_board, el.color)
        new_board[[row, col]].promote if el.kinged
      end
    end
    
    new_board
  end
  
  private
  
  def each_pos
    #iterates through every position of grid
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        yield(el, row_idx, col_idx)
      end
    end
  end
  
  def populate_grid
    each_pos do |el, row, col|
      if setup_board_bool?(row, col)
        self[[row, col]] = Piece.new([row, col], self, :white) if row.between?(5,7)
        self[[row, col]] = Piece.new([row, col], self, :red) if row.between?(0,2)
      end
    end
  end
  
  def setup_board_bool?(row_idx, col_idx)
    row_idx.even? && col_idx.odd? || row_idx.odd? && col_idx.even?
  end
  
end