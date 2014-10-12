#!/usr/bin/ruby



def factorial_rec(n)
  if n == 1
    1
  else 
    n*factorial_rec(n-1)
  end
end

def palindrome?(word)
  #recursively return whether a word is a palindrome
  if word.length <= 2
    return word[0] == word[-1]
  else
    if word[0] == word[-1]
      palindrome?(word[1..-2])
    else
      false
    end
  end
end

def bottles_beer(n)
  if n == 0
    puts "no more bottles left on the wall"
  else
    puts "#{n} bottles of beer left on the wall"
    bottles_beer(n-1)
  end
end


def fibs_rec(n,times=0)
  times +=1
  p times
  return 0 if n ==0
  return 1 if n == 1
  return fibs_rec(n-1,times)+fibs_rec(n-2,times)
end

def flatten_rec(arr, result = [])
  #base_case if arr = [1 element]
  arr.each do |item|
    if item.is_a?(Fixnum)
      result << item
    else
      flatten_rec(item,result)
    end
  end
  result
end


def roman_mapping_rec(num, result = [])
  
  $roman_mapping = {
    
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
  }
  p $roman_mapping
  if num == 0
    return result
  else
    $roman_mapping.each do |k,v|
      if num > k
        num-=k
        result << v
        roman_mapping_rec(num,result)
      end
    end
    result.join("")
  end
  #base case, is when num is 0, return the final result
  
end


def reverser_rec(string)
  return string if string.length <= 1
  str[-1]+reverser_rec(string[0...-1])
end
# p flatten_rec([[1,2],5,[3,4],[[1,2],[4,5],5]])



arr = [1,2,3,[1,2]]

def deep_dup(arr)
  new_arr = []
  arr.each do |el|
    if el.is_a?(Array)
      new_arr << deep_dup(el)
    else
      new_arr << el
    end
  end
  new_arr
end

#n array of fibs
def fibs_rec(n)
  if n <= 2
    [0, 1].take(n)
  else
    prev_fibs = fibs_rec(n-1)
    prev_fibs << prev_fibs[-1] + prev_fibs[-2]
  end
end

def bsearch(arr, target)
  mid = arr.length / 2
  
  if arr[mid] == target
    return mid
  elsif arr[mid] < target
    bsearch(arr[mid+1..-1], target) + mid + 1
  else
    bsearch(arr[0..mid-1], target)
  end
  
end



def subsets(arr)
  return [[]] if arr.empty?
  prev_set = subsets(arr[0...-1])
  new_set = prev_set.map do |set|
    set += [arr.last]
  end
  
  prev_set += new_set
end

def bsearch(array, target)
  return nil if array.empty?
  mid = array.length / 2
  
  if array[mid] == target
    return mid
  elsif array[mid] > target
    bsearch(array[0...mid], target)
  else
    subanswer = bsearch(array[mid+1..-1], target)
    subanswer.nil? ? nil : (subanswer + mid + 1 )
  end
  
end

arr = [1,2,3,4,6,22,66,111]
arr.each do |el|
  p bsearch(arr,el)
  p bsearch(arr,0)
end



