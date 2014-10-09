require 'ostruct'
class A
  def hi
    puts 5
  end
  
  private
  def lol
    puts 7
  end
end

class B
  def bye
    puts 3
  end
  class C < A
    
  end
end


