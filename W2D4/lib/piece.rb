# encoding: utf-8
require 'colorize'

class InvalidMoveError < StandardError
end

class NoPieceThere < StandardError
end

class NotYourPiece < StandardError
end

class CanJumpMustJump < StandardError
end

class Piece
  attr_reader :color, :kinged
  
  SLIDE_DEL ={
    white: [[-1, 1], [-1, -1]],
    red: [[1, 1], [1, -1]]
  }
  
  JUMP_DEL = {
    white: [[-2, 2], [-2, -2]], 
    red: [[2, 2],[2, -2]]
  }
  
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
    @kinged = false
  end
  
  def can_promote?
    return false if @kinged
    @color == :white ? @pos[0] == 0 : @pos[0] == 7
  end
  
  def promote
    @kinged = true
  end
  
  def symbol
    if @kinged
      @symbol = @color == :white ? "♠".white : "♠".red
    else
      @symbol = @color == :white ? "♥".white : "♥".red
    end
  end
  
  def perform_moves(move_seq, color)
    perform_moves!(move_seq) if valid_move_seq?(move_seq, color)
    promote if can_promote?
  end
  
  def perform_moves!(move_seq)
    if move_seq.count == 1
      if perform_slide(move_seq[0])
        return true
      elsif perform_jump(move_seq[0])
        raise CanJumpMustJump.new unless jump_diffs.empty?
      else
        raise InvalidMoveError.new
      end
    else # if move sequence is multiple long, must be all jumps
      move_seq.each do |move|
        raise InvalidMoveError.new unless perform_jump(move)
      end
    end
    raise CanJumpMustJump.new unless jump_diffs.empty?
    
    true
  end
  
  private
  
  def valid_move_seq?(move_seq, color)
    raise NotYourPiece.new() if @board[@pos].color != color
    new_b = @board.dup
    new_b[@pos].perform_moves!(move_seq)
    true
  end

  def perform_slide(to_pos)
    if slide_diffs.include?(to_pos)
      @board[to_pos] = self
      @board[@pos] = nil
      @pos = to_pos
      return true
    else
      return false
    end
  end
  
  def perform_jump(to_pos)
    if jump_diffs.include?(to_pos)
      @board[to_pos] = self
      @board[@pos] = nil
      @board[pos_in_mid(@pos, to_pos)] = nil
      @pos = to_pos
      true
    else
      false
    end
  end
  
  def slide_diffs
    moves = []
    deltas = @kinged ? SLIDE_DEL[:white] + SLIDE_DEL[:red] : SLIDE_DEL[@color]
    slide_pos = pos_add_delta(deltas)
    
    moves += slide_pos.select do |pos|
      @board.on_board?(pos) && @board[pos].nil?
    end
    
    moves
  end
  
  def jump_diffs
    moves = []
    deltas = @kinged ? JUMP_DEL[:white] + JUMP_DEL[:red] : JUMP_DEL[@color]
    jump_pos = pos_add_delta(deltas)
    
    jump_pos.each_with_index do |n_pos, idx|
      if @board.on_board?(n_pos) && @board[n_pos].nil? && !@board[pos_in_mid(@pos, n_pos)].nil? && @board[pos_in_mid(@pos, n_pos)].color != self.color
        moves << n_pos
      end
    end
    
    moves
  end
  
  def pos_in_mid(pos1, pos2)
    [(pos1[0] + pos2[0]) / 2, (pos1[1] + pos2[1]) / 2]
  end
  
  def pos_add_delta(deltas)
    #returns positions a piece can reach to by sliding
    deltas.map do |delta|
      comb_arr(@pos, delta)
    end
  end
  
  def comb_arr(arr1, arr2)
    [arr1[0] + arr2[0], arr1[1] + arr2[1]]
  end
end
