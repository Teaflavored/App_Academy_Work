def range(start,end_n,answer=[])
  return [] if end_n < start
  answer << start
  return answer if start == end_n
  range(start+1,end_n, answer)
end

def sum_iterative(arr)
  arr.inject(0,:+)
end

def sum_recursive(arr)
  return 0 if arr.empty?
  return arr.first if arr.size == 1
  arr.pop+sum_recursive(arr)
end

def exp(b, exponent)
  return 1 if exponent == 0
  return b * exp(b, exponent - 1)
end

def exp_2 (b, exponent, count = 1)
  p count += 1
  return 1 if exponent == 0
  return b if exponent == 1
  if exponent.even?
    return exp(exp_2(b, exponent / 2, count), 2)
  else
    return b * exp(exp_2(b, (exponent - 1) / 2, count), 2)
  end
end

def deep_dup(arr)
  result = []
  arr.each do |el|
    if !el.is_a?(Array)
      result << el
    else
      result << deep_dup(el)
    end
  end
  result
end

#def fibonacci(num, fib_arr = [0, 1, 1])
#  return fib_arr if num == 0
#  fib_arr << (fibonacci(num - 1, fib_arr) + fibonacci(num - 2, fib_arr))
#end



def fib(num, fib_arr = [0, 1, 1])
  if fib_arr.length == num
    return fib_arr
  else
    fib_arr << fib_arr[-1] + fib_arr[-2]
    p fib_arr
    fib(num, fib_arr)
  end
end

require 'debugger'

def fib(n)
  if n < 3
    fib_arr = [0, 1]
    return fib_arr.slice(0, n)
  end
  old_fib = fib(n - 1)
  new_num = old_fib[-1] + old_fib[-2]
  old_fib + [new_num]
end
#[1,2,3,4,5], search for 4
#mid = 2
#check arr[2] -> 3
#4 is bigger, search upperhalf from 2
# mid is 5
#arr[5] - > 6,
#0..5
#mid is 2 
#

def bsearch(arr, key)
  mid = (arr.length) / 2
  
  if arr[mid] == key
    return mid
  elsif arr[mid] > key
    bsearch(arr[0...mid], key)
  elsif arr[mid] < key
    return bsearch(arr[(mid + 1)..-1], key) + mid + 1
  end
  
end
[1,2,3,4].slice(0,2)
[1,2]
[3,4]

p bsearch([16,7,8,9,10,11,2,3,4,5,],11)
