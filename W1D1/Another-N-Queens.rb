require 'pp'


class QueenSolver
  
  attr_reader :max_row
  
  def initialize  
    #clear out the whole board and set every spot as blank
    @board = Array.new(8) { Array.new(8) { "b" } }
    @max_row = 7
  end
  
  def solve(row)
    #go through each one of the positions for one row, then if placed, go solve the next row
  
    (0..max_row).each do |col|
      if safe(row,col)
        #if it's safe, we can place a piece
        @board[row][col] = "Q"
        if row == max_row
          pp render
          exit
        else
          solve(row+1)
        end
        @board[row][col] = "b"
      end
    end
  end
  
  def safe(row,col)
    return false if !safe_row(row)
    return false if !safe_col(col)

    # Check the diagonals for safe.
    return false if !safe_diag(row, col, 1, 1)
    return false if !safe_diag(row, col, 1, -1)
    return false if !safe_diag(row, col, -1, 1)
    return false if !safe_diag(row, col, -1, -1)

    # Should be OK.
    return true
  end
  
  #need to figure this out
  def safe_diag(suggested_row, suggested_col, row_mod, col_mod)
       row,col = suggested_row+row_mod, suggested_col+col_mod
       while true do

           # Break out of the loop if the row or column is off the board.
           break if (row > @max_row) || (col > @max_row ) || (row < 0) || (col < 0)

           # If this row or column has a queen, then it's not safe.
           return false if @board[row][col] == "Q"
               
           # Move in the appropriate direction.
           row += row_mod
           col += col_mod
       end

       # This direction is safe.
       return true
   end

  
  #returns false for any row that's passed into row
  def safe_row(row)
    0.upto(max_row).each do |col|
      return false if @board[row][col] == "Q"
    end
    
    true
  end
  
  #returns false for any column that's passed into col
  def safe_col(col)
    0.upto(max_row).each do |row|
      return false if @board[row][col] == "Q"
    end
    
    true
  end
  
  def position_on_board(x,y) #returns true if the x and y is located within the grid
    horizontal = ( x >= 0 ) && ( x <= 7 )
    vertical = ( y >= 0 ) && ( y <= 7 )
    horizontal && vertical
  end
  
  def render 
    @board.each do |row|
      row.each do |col|
        col
      end
      "\n"
    end
  end
  
end


test = QueenSolver.new
pp test.solve(0)