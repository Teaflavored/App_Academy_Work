require 'pp'
class Maze
  def initialize
    lines = File.readlines(ARGV.first).map do |line|
      line.chomp
    end
    @maze = []
    lines.each do |line|
      @maze << line.split('')
    end

    @start = [] #start.first returns row of current, start.last returns col of current
    @fin = []

    @maze.each_with_index do |row,row_pos|
      row.each_with_index do |element, col_pos|
        if element == 'S'
          @start = [row_pos, col_pos]
        elsif element == 'E'
          @fin = [row_pos, col_pos]
        end
      end
    end
    
    @up = [@start.first-1,@start.last]
    @down = [@start.first+1,@start.last]
    @left = [@start.first, @start.last-1]
    @right = [@start.first,@start.last+1]
      pp @start, @fin
  end
  
  def check_move(current_pos) # [row,col]
    
  end
  
  def move_valid?(pos)
    pos_to_element(pos) == '*' ? false : true 
  end

  #returns element in maze for position row, col
  def pos_to_element(pos)
    @maze[pos.first][pos.last]
  end

end


testMaze = Maze.new