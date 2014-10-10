def merge_sort(arr)
  return arr if arr.length < 2
  mid = arr.length / 2
  left_part = merge_sort(arr[0...mid])
  right_part = merge_sort(arr[mid..-1]) 
  merge_helper(left_part,right_part)
end

def merge_helper(left_part,right_part)
  result = []
  idx_left = 0
  idx_right = 0
  
  
  while idx_left < left_part.length && idx_right < right_part.length
    if left_part[idx_left] < right_part[idx_right]
      result << left_part[idx_left]
      idx_left += 1
    else
      result << right_part[idx_right]
      idx_right += 1
    end
  end
  
  while idx_left < left_part.length
    result << left_part[idx_left]
    idx_left += 1
  end
  
  while idx_right < right_part.length
    result << right_part[idx_right]
    idx_right += 1
  end
  
  result
end
