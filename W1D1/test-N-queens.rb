require_relative 'N-queens.rb'
require 'test/unit'

class TestBoard < Test::Unit::TestCase
  
  
  def test_find_queens
    @test_board = Board.new
    @test_board.place_queen(2,1)
    @test_board.place_queen(4,4)
    assert_equal [[2,1],[4,4]], @test_board.find_queens.sort
  end
  
  def test_clear_index_seen_below
    @test_board = Board.new
    (3..7).each do |i|
      @test_board.index_seen[i] << 1
    end
    
    test_index_seen_not_empty = (3..7).all? do |i|
      @test_board.index_seen[i].length>=1
    end
    
    #first test for making sure successfully adding stuff to index_seen
    assert_equal true, test_index_seen_not_empty
    
    @test_board.clear_index_seen_below(2)
    
    test_index_seen_empty = (3..7).all? do |i|
      @test_board.index_seen[i].empty?
    end
    
    assert_equal true, test_index_seen_empty
    
  end
  
  
  def test_row_all_filled?
    @test_board = Board.new
    assert_equal true, @test_board.row_all_filled_up?([false,false,false,false,false])
  end
end