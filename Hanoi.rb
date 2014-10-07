require 'pp'
def hanoi_game
  start = []
  transition = []
  final = []
  names = { 1 => start, 2 => transition, 3 => final }
  
  puts "How many pieces?"
  pieces = gets.chomp.to_i
  pieces.downto(1).each do |i|
    start << i
  end
  solution = start.dup
  
  while final != solution
    puts "From which? 1, 2 or 3 (3 is the destination)"
    from = gets.chomp.to_i
    puts "To which? 1, 2, or 3"
    to = gets.chomp.to_i
    
    piece = names[from].pop
    
    if names[to].empty? || names[to].last > piece
      names[to] << piece
    else
      names[from] << piece
    end
    pp "1: #{start}"
    pp "2: #{transition}"
    pp "3: #{final}"
  end
  puts "You win!"
end

hanoi_game