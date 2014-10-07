@@stack = 0
def num_to_s(num=100,base=2)
  
  @@stack+=1
  return "0" if num == 0
  
  low_digit = num % base
  leftover = num - low_digit #leftover is multiple of base after removing the remainder
  puts "Current stack is #{@@stack}"
  puts "leftover is #{leftover}"
  puts "num is #{num}"
  puts "base is #{base}"
  digits = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
  
  if leftover > 0
    num_to_s(leftover / base, base) + digits[low_digit]
  else
    digits[low_digit]
  end
end

puts num_to_s