require_relative 'piece.rb'

class SteppingPiece < Piece
  
  def possible_valid_moves
    moves = []
    
    self.class::DELTAS.each do |coord|
      new_position = [coord, @pos].transpose.map{|x| x.reduce(:+)}
      moves << new_position if piece_can_move_to?(new_position)
    end
    
    moves
  end
  
  def piece_can_move_to?(pos)
    row, col = pos
    return false unless on_board?(pos)
    square = @board.grid[row][col]
    square.nil? || square.color != self.color
  end
  
end