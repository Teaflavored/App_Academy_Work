require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :prev_move_pos, :board, :next_mover_mark
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    #base case
    if @board.over?
      #@board.winner could be nil, us, or them
      return @board.winner == (evaluator == :o ? :x : :o)
    end
    
    if evaluator == @next_mover_mark
      children.all? { |child| child.losing_node?(evaluator)}
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end
  
  def other_mark
    if @next_mover_mark == :x
      :o
    else
      :x
    end
  end
  
  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end
    
    if evaluator == @next_mover_mark
      children.any? { |child| child.winning_node?(evaluator)}
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_children = []
    
   (0..2).each do |row|
      (0..2).each do |col|
        if @board.rows[row][col].nil?
          new_board = @board.dup
          new_board.rows[row][col] = @next_mover_mark
          all_children << TicTacToeNode.new(new_board, other_mark,[row,col])
        end
        
      end
    end
    
    all_children
  end
  
  
  
  
  
  
end
