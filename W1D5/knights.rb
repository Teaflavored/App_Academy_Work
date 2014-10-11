require_relative 'treenode.rb'

class KnightPathFinder
  KNIGHT_MOVES = [[-2,-1],[-2,1],[2,1],[2,-1],[-1,2],[-1,-2],[1,2],[1,-2]]
  
  def initialize(array_position)
    @start_node = PolyTreeNode.new(array_position)
    @visited_positions = [array_position]
  end
  
  def self.on_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end
  
  def self.valid_moves(pos)
    #returns array of possible positions
    row,col = pos
    KNIGHT_MOVES.map do |move|
      new_pos = [row + move.first, col + move.last]
      if self.on_board?(new_pos)
        new_pos
      else
        next
      end
    end.compact # refactor later
  end
  
  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos) - @visited_positions
  end
  
  def build_move_tree
    queue = [@start_node]
    
    until queue.empty?
      break if @visited_positions.size == 64
      current = queue.shift
      all_moves = new_move_positions(current.value)
      
      all_moves.each do |move|
        current.add_child(PolyTreeNode.new(move))
        @visited_positions << move
      end
      
      current.children.each do |child|
        queue << child
      end
      
    end
    
    nil
  end
  
  def find_path(position)
    (@start_node.dfs(position).trace_path_back << @start_node.value).reverse
  end
  
end

k = KnightPathFinder.new([0, 0])

k.build_move_tree
p k.find_path([6, 2])
