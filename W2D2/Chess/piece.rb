class Piece
  attr_reader :piece_unicode, :color
  
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end
  
  def on_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end
  
  def set_new_current_position(new_pos)
    @pos = new_pos
  end
  
  def move_into_check?(end_pos)
    board_dup = @board.dup
    board_dup.move_piece(@pos, end_pos)
    board_dup.in_check?(self.color)
  end
  
end

