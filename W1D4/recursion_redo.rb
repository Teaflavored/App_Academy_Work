def range(start, end_point) 
  #base case
  return [] if end_point < start
  return [start] + range(start+1, end_point)
end

def sum_of_array(arr)
  arr.inject(:+)
end

p sum_of_array([1,2,3])

def sum_rec(arr)
  return arr.first if arr.count == 1
  arr.last + sum_rec(arr[0...-1])
end

p sum_rec([1,2,3])

def bsearch(arr, target)
  return nil if arr.empty?
  mid = arr.length / 2 
  
  if arr[mid] == target
    return mid
  elsif arr[mid] > target
    bsearch(arr[0...mid], target)
  else
    subanswer = bsearch(arr[mid+1..-1], target)
    subanswer.nil? ? (return nil) : (subanswer + mid + 1)
  end
end

def merge_sort(arr)
  #base case 
  return arr if arr.count < 2
  #already sorted if array length of 1
  #else keep splitting then combining them
  #take everything up to and including mid
  #[1,2,3,4]
  mid = arr.length / 2
  part_a = merge_sort(arr[0...mid])
  part_b = merge_sort(arr[mid..-1])
  
  merge(part_a, part_b)
  
  
end

def merge(arr1, arr2)
  
  arr = []
  
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      arr << arr1.shift
    else
      arr << arr2.shift
    end
  end
  
  arr+arr1+arr2
end


def subsets(arr)
  return [[]] if arr.empty?
  
  prev_sets = subsets(arr[0..-2])
  new_sets = prev_sets.map do |set|
    ([arr.last] + set).sort
  end
  
  prev_sets + new_sets
end

def exp1(base, n, count = 0)
  count += 1
  p count if count > 100
  return 1 if n == 0
  return base * exp1(base, n - 1, count)
end

#for n == 256, this one will make 257 calls to the function

def exp2(base, n , count = 0)
  count += 1
  p count if count > 5
  return 1 if n == 0
  return base if n == 1 
  if n.even?
    subanswer = exp2(base, n / 2, count)
    return subanswer * subanswer
  else
    subanswer = exp2(base, (n-1) / 2, count)
    return base * subanswer* subanswer
  end
end

def deep_dup(arr)
  duped_array = []
  arr.each do |el|
    if el.is_a?(Array)
      duped_array << deep_dup(el)
    else
      duped_array << el.dup
    end
  end
  duped_array
end

def fib(n)
  #return array of n numbers of fib sequence
  #base fib has [0,1]
  if n <= 2
    return [0,1].take(n)
  else
    prev_fibs = fib(n-1)
    new_num = prev_fibs[-1] + prev_fibs[-2]
    return prev_fibs << new_num
  end
end

def bsearch(array, target)
  #divide by half depending on mid compared to target
  return nil if array.empty?
  
  mid = array.length / 2
  if array[mid] == target
    return mid
  elsif array[mid] > target
    return bsearch(array[0...mid], target)
  else
    subsearch = bsearch(array[mid+1..-1], target)
    subsearch.nil? ? (return nil) : (return subsearch + mid + 1)
  end
end

arr = [1,2,3,4,5]

arr.each do |el|
  p bsearch(arr, 7)
end