def picker(array)
  maximum = nil
  buy_sell = []
  array.each_with_index do |buy_price, buy_date|
    (buy_date+1..array.length-1).each do |sell_date|
      if maximum.nil? || array[sell_date] - array[buy_date] > maximum
        maximum = array[sell_date] - array[buy_date]
        buy_sell = [buy_date, sell_date]
      end
    end
  end
  puts buy_sell.inspect
end

picker([2,4,6,2])