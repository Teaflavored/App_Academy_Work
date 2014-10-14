require 'colorize'

class Tile
  
  attr_reader :revealed, :bombed, :flagged, :pos
  NEIGHBOR_POS = [
    [1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]
  ]
  
  def initialize(pos, board)
    @revealed = false
    @bombed = false
    @flagged = false
    @pos = pos
    @board = board
    @current = false
  end
    
  def neighbors_not_revealed
    neighbors.select do |neighbor|
      !neighbor.revealed
    end
  end
  
  def set_bomb
    @bombed = true
  end
  
  def set_flag # might be cool to have a toggle
    @flagged = true unless @revealed
  end
  
  def remove_flag 
    @flagged = false 
  end
  
  def reveal
    @revealed = true
  end
  
  def num_of_bombs
    # @bombed_neighbors ||= 
    number_of_bombs = 0
    neighbors.each do |neighbor|
      number_of_bombs += 1 if neighbor.bombed 
    end
    
    number_of_bombs
  end
  
  def toggle_current
    if @current
      @current = false
    else
      @current = true
    end
  end 
  
  def show_tile
    cursor = @revealed ? revealed_tile.black.on_green : hidden_tile

    blink(cursor)
  end
  
  
  
  private
  
  def blink(cursor)
    @current ? (return cursor.white.on_black.blink ): (return cursor) 
  end
  
  def revealed_tile
    if @bombed
      "[*]"
    else
      result = num_of_bombs
      "[#{result == 0 ? ("-") : ("#{ result.to_s.black }") }]"
    end
  end
  
  def hidden_tile
    if @flagged
      "[F]".light_blue.on_red
    else
      "[ ]".white.on_blue
    end
  end
  
  
  def on_board?(arr)
    new_row, new_col = arr
    b_width, b_height = @board.width, @board.height
    new_row.between?(0, b_width - 1) && new_col.between?(0, b_height - 1)
  end
  
  def get_new_neighbor_pos(pos)
    [pos, @pos].transpose.map { |x| x.inject(:+) }
  end
  
  def neighbors
    neighbors = []
    
    NEIGHBOR_POS.each do |n_pos| # map
      new_arr = get_new_neighbor_pos(n_pos)
      if on_board?(new_arr)
        neighbors << @board.get_tile_at_pos(new_arr)
      end    
    end
    
    neighbors
  end
  
end
