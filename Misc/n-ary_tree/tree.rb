require_relative 'node.rb'

class Tree
  
  attr_reader :root
  
  def initialize(root)
    @root = Node.new(root)
    @all_seen_pos = [0]
  end
  
  def add_child(items)
    #for every item, we generate more items to add unless that item has been seen already
  end
  
  def test
  end
  
  def dfs(start, level = 0)
    p start.item
    p "level #{level}"
    level += 1
    if !start.children.empty?
      start.children.each do |child|
        dfs(child)
      end
    end
  end

  
  def run
    dfs(@root)
  end
end


test = Tree.new(5)
test.test
test.run
