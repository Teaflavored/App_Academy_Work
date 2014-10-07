require 'debugger'

def prime?(num)
  debugger

  (1..num).each do |i|
    if (num % i) == 0
      return false
    end
  end
end