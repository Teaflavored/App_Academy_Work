def merge_sort(arr)
  #divide
  return arr if arr.length <=1
  mid = arr.length/2
  part_left = merge_sort(arr.slice(0,mid))
  part_right = merge_sort(arr.slice(mid,arr.length-mid))
  
  arr = []
  part_l_index = 0
  part_r_index = 0
  while part_l_index < part_left.length && part_r_index < part_right.length
    if part_left[part_l_index] < part_right[part_r_index]
      arr << part_left[part_l_index]
      part_l_index+=1
    else
      arr << part_right[part_r_index]
      part_r_index+=1
    end
  end
  
  while part_l_index < part_left.length
    
    arr << part_left[part_l_index]
    part_l_index+=1
  end

  while part_r_index < part_right.length
    arr << part_right[part_r_index]
    part_r_index+=1
    
  end
  
  arr
end


# p merge_sort([5,3,2,7,1,5,44,4,4,4])
#[1,2,3,4,5]
#key = 1
#mid = 2, value = 3
#first loop
#binary_search(arr,key,0,2)
#mid = 1
#arr[mid] = 2
#binary_search(arr,key,0,1)
#mid = 0
#arr[0]==1
#return mid

def binary_search(arr,key,from=0,to=nil)
  if to.nil?
    to = arr.length
  end
  
  mid = (from+to)/2
  
  if arr[mid] == key
    #base case
    return mid
  elsif arr[mid] > key
    binary_search(arr,key,0,mid)
  else
    binary_search(arr,key,mid+1,arr.length-1)
  end
end



p binary_search([1,2,3,4,5,6,11,33,34])