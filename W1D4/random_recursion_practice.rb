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

p fibs_rec(15)

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