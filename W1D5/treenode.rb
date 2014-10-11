class PolyTreeNode
  attr_accessor :children, :value
  attr_reader :parent
  
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    @parent.children << self  unless @parent.nil?
  end
  
  def add_child(child_node)
    child_node.parent = self
    @children << child_node
    child_node
  end
  
  def remove_child(child)
    raise unless @children.include?(child)
    child.parent = nil
    @children.delete(child)
  end
  
  def dfs(value)
    return self if self.value == value
    
    @children.each do |child|
      current_child = child.dfs(value)
      if !current_child.nil? && current_child.value == value
        return current_child
      end
    end
    
    nil
  end
  
  def bfs(value)
    queue = [self]
    
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == value
      
      current_node.children.each do |child|
        queue << child
      end
    end
    
    nil
  end
  
  def trace_path_back
    path = []
    current = self
    
    until current.parent.nil?
      path << current.value
      current = current.parent
    end
    
    path
  end
end
