def our_loop
  i=250
  i+=1 until i % 7 == 0
  i
end

def factors(n)
  [].tap do |factors|
    (1..n).each do |i|
      factors << i if n % i == 0
    end
  end
end

def bubble_sort(arr)
  
  flag = true
  while flag
    flag=false
    (0..arr.length-2).each do |i|
      if arr[i] > arr[i+1]
        arr[i],arr[i+1] = arr[i+1],arr[i]
        flag = true
      end
    end
  end
  arr
end


# p bubble_sort([5,4,3,2,1])



def substrings(string)
  lines = File.read('dictionary.txt').split("\n")
  lines = File.readlines('dictionary.txt').map(&:chomp)
  output_arr = []
  string.split('').each_index do |i|
    (i..string.length - 1).each do |j|
      output_arr << string[i..j] if lines.include?(string[i..j])
    end  
  end
  
  output_arr
end

p substrings("cat")