def my_uniq(array)
  uniq_array = []
  array.each do |el|
    uniq_array << el unless uniq_array.include?(el)
  end
  uniq_array
end

def my_uniq(array)
  array.inject([]) do |uniq_array, el|
    uniq_array << el unless uniq_array.include?(el)
    uniq_array
  end
end


def transpose(rows)
  dimension = rows.first.count #returns the dimension of square
  cols = Array.new(dimension) { Array.new(dimension) }
  
  dimension.times do |i|
    dimension.times do |j|
      cols[j][i] = rows[i][j]
    end
  end
  
  cols
end

puts transpose([[1,2],[3,4]]).inspect