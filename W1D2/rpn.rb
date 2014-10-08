class RPNCalculator
  attr_reader :stack, :input
  
  def initialize
    @stack = []
    @input = get_input
  end
  
  def plus
    num1 = stack.pop
    num2 = stack.pop
    stack.push(num2 + num1)
  end
  
  def minus
    num1 = stack.pop
    num2 = stack.pop
    stack.push(num2 - num1)
  end
  
  def multiply
    num1 = stack.pop
    num2 = stack.pop
    stack.push(num2 * num1)
  end
  
  def divide
    num1 = stack.pop
    num2 = stack.pop
    stack.push(num2 / num1)
  end
  
  
  def solve
    input.each do |item|        
      if item == '+'
        plus
      elsif item == '-'
        minus
      elsif item == '*'
        multiply
      elsif item == '/'
        divide
      else
        stack << item.to_i
      end
    end
    stack.pop
  end
  
  def get_input
    if ARGV.empty?
      calc_array = []
      loop do
        get_prompt = user_input
        return calc_array if get_prompt == 'q'
        calc_array << get_prompt
      end
    else
      read_from_file(ARGV.first)
    end
  end
  
  def read_from_file(file)
    line = File.read(file).gsub(/\s+/,"").split('')
  end
  
  def user_input
    loop do 
      puts "Give operation or operand:"
      input = gets.chomp
      return input if input.match(/[\d\+\-\/\*q]/) 
    end
  end
  
end


test = RPNCalculator.new
p test.solve

#
# 17-3
#
# 3
# 17
#
#
# 12
# 5
#
# *
#
# 4
# 3
# 5
#
#
# 2+1 = 3
#
# +
#
#
# 2
# 1
# 5