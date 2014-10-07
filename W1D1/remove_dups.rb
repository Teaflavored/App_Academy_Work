class Array
  def my_uniq
    output_array = []
    self.each do |element|
      output_array << element if !output_array.include?(element)
    end
    output_array
  end
  
  def two_sum
    output_array = []
    self.each_with_index do |ele1, idx1|
      (idx1+1..self.length-1).each do |idx2|
        if self[idx1] + self[idx2] == 0
          output_array << [idx1,idx2]
        end
      end
    end
    output_array
  end
end
