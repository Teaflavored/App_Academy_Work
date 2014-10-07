def num_to_s(num,base)
  result = ""
  hex_dict = {
    0 => "0", 
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "A",
    11=> "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F"
  }
  i = 0
  until base**i > num
    result.prepend(hex_dict[(num/base**i)%base])
    i+=1
  end
  result
end


puts num_to_s(234,2)
puts num_to_s(234,16)