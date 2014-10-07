def my_transpose(array)
  output_array = []
  array.length.times do
    output_array << []
  end
  
  array.each do |row|
    row.each_with_index do |element, index|
      output_array[index] << element 
    end
  end
  
  puts output_array.inspect
end

my_transpose([[0, 3, 6], [1, 4, 7], [2, 5, 8]])