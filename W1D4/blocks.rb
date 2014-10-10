class Array
  def my_each 
    for i in (0...self.length)
      yield self[i]
    end
  end
  
  def my_map
    [].tap do |result|
      self.my_each do |element|
        result << yield(element)
      end
    end
  end
  
  def my_select
    [].tap do |result|
      self.my_each do |element|
        result << element if yield(element)
      end
    end
  end
  
  def my_inject
    result = self.first
    self.my_each do |el|
      result = yield(result, el)
    end
    result
  end

  def my_sort!(&proc)
    sorted = false
    
    until sorted
      sorted = true
      self.each_with_index do |value, idx|
        next if idx == self.length - 1
        if proc.call(value, self[idx + 1]) == -1
          next
        elsif proc.call(value, self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    
    self
  end
  
  def my_sort(&proc)
    test_arr = self.dup
    test_arr.my_sort!(&proc)
  end
  
end

def eval_block(*args)
  return "No Block Given" unless block_given?
  yield(*args)
end