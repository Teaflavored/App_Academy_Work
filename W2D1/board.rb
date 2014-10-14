require_relative "tile.rb"
require 'debugger'

class MinesweeperError < StandardError; end

class Board
  attr_reader :grid, :width, :height 
  
  def initialize(width, height, num_bombs)
    @width = width
    @height = height
    @num_bombs = num_bombs
    @grid = Array.new(@height) { Array.new(@width) }
    populate_grid
    populate_bombs(num_bombs)
    initialize_current
  end
  

  
  def display_board
    alphabet = ("A".."Z").to_a.take(@width)
    puts "[#{(alphabet.join "][")}]"
    
    @grid.each_with_index do |row, row_index|
      row.each do |el|
        print el.show_tile
      end
      puts row_index
    end
  end
  
  def reveal_tile(pos)
    tile = get_tile_at_pos(pos)
    
    return nil if tile.flagged
    
    if tile.bombed
      reveal_all_bombs
      return # nil
    end
    
    if tile.num_of_bombs > 0
      tile.reveal
      return nil
    elsif tile.num_of_bombs == 0
      tile.reveal
      neighbors = tile.neighbors_not_revealed
      return nil if neighbors.empty?
      neighbors.each do |neighbor|
        reveal_tile(neighbor.pos)
      end
    end
    #if !tile.reveal
  end
  
  def over?
    count_unrevealed == @num_bombs
  end
  
  def switch_flag(pos)
    row, col = pos
    tile = @grid[row][col]
    tile.flagged ? tile.remove_flag : tile.set_flag
  end
  
  def get_tile_at_pos(pos)
    row, col = pos
    @grid[row][col]
  end
  
  
  private
  
  def count_unrevealed
    num = 0
    @grid.each do |row|
      row.each do |el|
        num += 1 unless el.revealed
      end
    end
    
    num
  end
  
  def populate_grid
    @grid.each_index do |rowidx|
      @grid[rowidx].each_index do |colidx|
        @grid[rowidx][colidx] = Tile.new([rowidx, colidx], self)
      end
    end
    
  end
  
  def initialize_current
    @grid[0][0].toggle_current
  end
  
  def populate_bombs(num_bombs)
    
    until num_bombs == 0
      rand_row = rand(@height)
      rand_col = rand(@width)
      tile = @grid[rand_row][rand_col]
      if !tile.bombed
        tile.set_bomb
        num_bombs -= 1
      end
    end
  end
  
  def reveal_all_bombs
    @grid.each do |row|
      row.each do |el|
        el.reveal if el.bombed
      end
    end
    display_board
    raise MinesweeperError.new("Game Over")
  end
  
end


