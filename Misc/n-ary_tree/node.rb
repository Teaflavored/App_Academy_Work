class Node
  
  attr_accessor :item, :children
  
  def initialize(item, children = [])
    @item = item
    @children = children
  end
  
  def add_child(item)
    @children << Node.new(item)
  end
  
  def add_children(items)
    items.each do |item|
      @children << Node.new(item)
    end
  end
end