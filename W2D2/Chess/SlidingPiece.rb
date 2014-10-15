require_relative "piece.rb"

class SlidingPiece < Piece
  
  def possible_valid_moves 
    moves = []
    self.class::DELTAS.each do |delta|
      moves += create_path_in_direction(@pos, delta)
    end
    
    moves
  end
  
  def create_path_in_direction(start, direction)
    path = []
    new_pos = [start[0] + direction[0], start[1] + direction[1]]
    
    while on_board?(new_pos) 
      if @board[new_pos].nil? 
        path << new_pos
      else
        if @board[new_pos].color == self.color
          return path
        else
          path << new_pos
          return path
        end
      end
      new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
    end
    path
  end
  
end

