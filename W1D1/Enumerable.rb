def times_two(arr)
  arr.map { |x| x * 2 }
end


class Array
  def my_each(&block)
    for i in (0..self.length - 1)
      block.call(self[i])
    end
  end
  
  def median
    if self.length.odd?
      self.sort[self.length / 2]
    else
      (self.sort[self.length / 2] + self.sort[self.length / 2 - 1]) / 2.0
    end
  end

end

def my_concat(arr_strings)
  arr_strings.inject(:+)
end