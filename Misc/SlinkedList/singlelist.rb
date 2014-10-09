require_relative 'node.rb'


class SingleList

  attr_reader :list_size
  
  def initialize(head=nil)
    @head = Node.new(head)
    @list_size = 1
  end
  
  def add_item_to_front(item)
    temp = Node.new(item)
    temp.next = @head
    @head = temp
    @list_size+=1
  end
  
  def add_item_to_end(item)
    current = traverse(list_size)
    temp = Node.new(item)
    current.next = temp
    @list_size+=1
  end
  
  def traverse(n)
    #returns node at nth position
    return nil if n > @list_size || n <= 0
    current = @head
    (n-1).times do
      current = current.next
    end
    current
  end
  
  def print_list
    current = @head
    while(current!=nil)
      print current.item
      current=current.next
    end
    puts
  end
  
end


testList = SingleList.new(1)
testList.add_item_to_front(3)
testList.add_item_to_front(4)
testList.add_item_to_front(4)
testList.add_item_to_end(3)
testList.print_list
print testList.traverse(5).item