require 'pp'
class Board
  
  attr_reader :board, :index_seen
  attr_writer :index_seen
  def initialize 
    
    
    set_board_to_all_true #also creates the @board variable
    
    #the current row we want to place the queens
    @queen_row = 0
    
    #create an array of queens, which are denoted by 1's 
    @queens = Array.new(8) { |x| 1 }
    
    #index for tried positions at each row
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
    
    @queen_positions = []
  end
  
  
  #sets the whole board to true
  def set_board_to_all_true
    @board = Array.new(8) do |row|
      Array.new(8) { |x| true }
    end
  end

  #returns array of the current queens in the board 
  def find_queens 
    queens = []
    @board.each_with_index do |row, row_pos|
      row.each_with_index do |ele, col_pos|
        queens << [row_pos,col_pos] if @board[row_pos][col_pos] == 1
      end
    end
    queens
  end
  
  
  #change the board so that up/down and diagnals are changed to false
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
  
  #if any row hits all falses, then we need to go back up a queen row
  
  def placement_of_pieces
    
    until queens_all_gone?
      #only stop the placement once all the queens have been placed
      
      
      #take the current row as the first one 
      current_row = @board[@queen_row]
      current_row.each_with_index do |element,idx|
        #go through every single element of the row and take the first true 
        #and it's not on the index
        placed_flag = false
        filled_flag = false
        if element && !@index_seen[@queen_row].include?(idx)
          @index_seen[@queen_row] << idx
          @queen_positions << [@queen_row,idx]
          place_queen(@queen_row, idx)
          @queen_row+=1
          placed_flag = true
          
        elsif row_all_filled_up?(@board[@queen_row])
          
          #else if the row is all filled_up with false
          #then we need to head up a row
          
          @queen_row =- 1
          clear_index_seen_below(@queen_row-1)
          #set_board_to_all_true_below_row(@queen_row-1)
          pp "#{@queen_positions} here are the queens"
          
          set_board_to_all_true
          @queens = Array.new(8) { |x| 1 }
          
          @queen_positions.pop
          
          @queen_positions.each_with_index do |position,idx|
            place_queen(position.first,position.last)
          end
          @queen_positions = []
          filled_flag = true
        end
        break if placed_flag || filled_flag
        pp @queen_row
        
      end

    end
    

  end

  def clear_index_seen_below(row)
    row.upto(7).each do |i|
      @index_seen[i+1] = []
    end
  end
  
  def row_all_filled_up?(row)
    #true if row is all false
    row.all? { |x| x == false || x == 1}
    
  end
  
  def queens_all_gone?
    @queens.empty?
  end
  
  def place_queen(row,col)
    @board[row][col] = @queens.pop
    change_board(row,col)
  end
end

board = Board.new
board.placement_of_pieces