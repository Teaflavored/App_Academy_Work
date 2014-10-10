def make_change(amount, coins)
  return [] if amount == 0
  best_change = Array.new(amount + 1)
  puts "start amount #{amount}"
  
  coins.each_index do |idx|
    if amount >= coins[idx]
      result = []
      result << coins[idx] # result = [1]
      new_amount = amount - coins[idx]
      puts "Result: #{result} amount = #{amount} coins #{coins}"
      result = result + make_change(new_amount, coins) 
      best_change = result if result.size < best_change.size 
    end
  end
  
  best_change

end
