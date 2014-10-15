class Array
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end
  
  def my_map
    new_arr = []
    self.my_each do |el|
      new_arr << yield(el)
    end
    
    new_arr
  end
  
  def my_select
    new_arr = []
    self.my_each do |el|
      new_arr << el if yield(el)
    end
    
    new_arr
  end
  
  def my_inject
    sum = 0
    self.my_each do |el|
      sum = yield(sum, el)
    end
    
    sum
  end
  
  def my_sort!
    sorted = false
    
    while !sorted
      sorted = true
      
      self.each_index do |idx|
        next if idx == self.length - 1
        if yield(self[idx], self[idx+1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
      
    end
  end
  
  def my_sort(&proc)
    another_copy = self.dup
    another_copy.my_sort!(&proc)
    
    another_copy
  end
  
  
end

def eval_block(*args)
  return "NO BLOCK GIVEN" unless block_given?
  yield(*args)
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end

eval_block(1,2,3,4,5) do |*args|
  p args.inject(:+)
end

p eval_block(1, 2, 3)