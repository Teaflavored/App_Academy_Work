def subsets(arr)
  return [[]] if arr.length == 0
  prev_sets = subsets(arr[0...-1])
  new_sets = prev_sets.map do |set|
    set += [arr.last]
  end
  
  prev_sets.concat(new_sets)
  
end
