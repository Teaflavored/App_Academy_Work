class TowersOfHanoi
  
  attr_accessor :towers
  
  def initialize
    @towers = [[3, 2, 1],[],[]]
  end
  
  def game_over?
    @towers[0].empty? && ( @towers[1].empty? || @towers[2].empty? )
  end
  
  def move_piece(from, to)
    raise "move not valid" unless valid?(from, to)
    @towers[to] << @towers[from].pop
  end
  
  def valid?(from, to)
    @towers[to].empty? || @towers[from][-1] < @towers[to][-1]
  end
  
  
end