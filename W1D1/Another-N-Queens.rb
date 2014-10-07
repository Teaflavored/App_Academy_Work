require 'pp'
require 'test/unit'

class QueenSolver
  
  
  def initialize
    
    #clear out the whole board and set every spot as true
    @board = Array.new(8) { Array.new(8) { true } }
    
    #Fixnum of 1 represents a queen, and there are a total of 8 queens to place
    @queens = Array.new(8) { 1 }
    
  end
  
  def possible_placements(row) #passes a row and returns array of idx of open positions
    [].tap do |positions|
      row.each_with_index do |el,idx|
        positions << idx if el
      end
    end
  end
   
  def queens_all_gone? #returns true once all the queens have been placed
    @queens.empty?
  end
  
  def row_filled_up?(row) #returns true if there are no open slots left
    row.all? { |el| el != true }
  end
  
end

class TestQueenSolver < Test::Unit::TestCase
  def test_possible_placement
    test = QueenSolver.new
    assert_equal [1,2], test.possible_placements([false,true,true,false])
    assert_equal [0,1,7], test.possible_placements([true,true,false,false,false,false,false,true])
  end
  
  def test_row_filled_up?
    test = QueenSolver.new
    assert_equal true, test.row_filled_up?([1,false,1,1,false,false,false,false])
  end
end