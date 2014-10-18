class Array
  def my_uniq
    seen = []
    self.each do |el|
      seen << el unless seen.include?(el)
    end
    
    seen
  end
  
  def two_sum
    result = []
    self.each_with_index do |el1, idx1|
      self.each_with_index do |el2, idx2|
        next if idx2 <= idx1
        result << [idx1, idx2] if el1 + el2 == 0
      end
    end
    
    result
  end
  
  def my_transpose
    result = Array.new(self.length) { Array.new(self.length) }
    self.each_with_index do |el1, idx1|
      el1.each_with_index do |el2, idx2|
        result[idx2][idx1] = el2
      end
    end
    
    result
  end
  
  def stock_picker
    max = 0
    buy = 0
    sell = 0
    self.each_with_index do |el1, idx1|
      (idx1+1...self.length).each do |idx2|
        profit = self[idx2] - self[idx1]
        if profit > max
          max = profit
          buy = idx1
          sell = idx2
        end
      end
    end
    
    [buy, sell]          
  end
  
end