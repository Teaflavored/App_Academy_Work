require 'pp'
class Board
  def initialize 
    clear_board
    @queen_row = 0
    @queens = Array.new(8) { |x| 1 }
    
     #everytime we want to place new queen
    @first_queen_col = 0 #marks position of the first queen
  end
  
  def clear_board
    @board = Array.new(8) do |row|
      Array.new(8) { |x| true }
    end

    @index_seen = {
      0 => [],
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [],
      6 => [],
      7 => [] 
    }
  end
  
  def find_queens 
    queens = {}
    @board.each_with_index do |row, row_pos|
      row.each_with_index do |ele, col_pos|
        queens[[row_pos,col_pos]] = true
      end
    end
    queens
  end
  
  
  def change_board(row,col)
    (row+1).upto(7).each do |i|
      @board[i][col] = false
    end
    (row-1).downto(0).each do |i|
      @board[i][col] = false
    end unless row ==0
    (col-1).downto(0).each do |i|
      @board[row][i] = false
    end unless col ==0
    (col+1).upto(7).each do |i|
      @board[row][i] = false
    end

    diff = 1
    (row-1).downto(0).each do |i|
      @board[row-diff][col-diff] = false unless row - diff < 0 || col - diff < 0
      @board[row-diff][col+diff] = false unless row - diff < 0 || col + diff > 7
      diff+=1
    end unless row ==0 
    
    diff = 1
    (row+1).upto(7).each do |i|
      @board[row+diff][col-diff] = false unless col - diff < 0 || row+diff > 7 
      @board[row+diff][col+diff] = false unless col + diff > 7 || row+diff > 7
      diff+=1
    end
    
  end
  
  def next_placement

    until all_filled_up? && queens_all_gone?
      current_row = @board[@queen_row]
      current_row.each_with_index do |element, idx|
        if element && !@index_seen[@queen_row].include?(idx)
          place_queen(@queen_row, idx)
          @index_seen[@queen_row] << idx
        else
          if row_all_filled_up?(current_row)
            @queen_row =-1
            clear_index_seen_below(@queen_row)
            clear_board
            find_queens.each_key do |key|
              change_board(key.first,key.last)
            end
            @queens = Array.new(find_queens.length) { |x| 1 }
          end
        end
      end
      
      board
    end
    
    
  end
  
  def clear_index_seen_below(row)
    r = row + 1 
    r.upto(7).each do |i|
      @index_seen[i] = []
    end
  end
  
  #returns true if there are no spaces left to place queens
  def all_filled_up?
    @board.all? { |row| row.all? { |element| element != true } }
  end
  
  def row_all_filled_up?(row)
    #true if row is all false
    row.all? { |x| x == false }
    
  end
  
  def queens_all_gone?
    @queens.empty?
  end
  
  def place_queen(row,col)
    @board[row][col] = @queens.pop
    change_board(row,col)
    @queen_row+=1
  end
  
  def board
    pp @board
  end
end

testBoard = Board.new
testBoard.next_placement
# testBoard.place_queen(3,0)
# testBoard.place_queen(5,1)
# testBoard.place_queen(7,2)
# testBoard.place_queen(1,3)
# testBoard.place_queen(6,4)
# testBoard.place_queen(0,5)
# testBoard.place_queen(2,6)
# testBoard.place_queen(4,7)
# pp testBoard.all_filled_up?
# pp testBoard.queens_all_gone?
# testBoard.board