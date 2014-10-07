class MyHashSet
  attr_reader :store
  
  def initialize
    @store = Hash.new(false)
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store[el]
  end
  
  def delete(el)
    @store.delete(el)
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    result_set = MyHashSet.new
    self.to_a.each do |element|
      result_set.insert(element)
    end
    
    set2.to_a.each do |element|
      result_set.insert(element) unless result_set.include?(element)
    end
    result_set
  end
  
  def intersect(set2)
    result_set = MyHashSet.new
    self.to_a.each do |element|
      result_set.insert(element) if set2.include?(element)
    end
    result_set 
  end
  
  def minus(set2)
    result_set = MyHashSet.new
    self.to_a.each do |element|
      result_set.insert(element) unless set2.include?(element)
    end
    result_set 
  end
end

test = MyHashSet.new
test.insert(1)
test.insert(2)
test2 = MyHashSet.new
test2.insert(2)
test2.insert(3)

puts test.minus(test2).inspect
