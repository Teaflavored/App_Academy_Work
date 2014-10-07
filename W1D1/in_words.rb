class Fixnum
  def in_words
    my_string = self.to_s
    final_string = ''
    group_place = { 0 => '', 1 => ' thousand ', 2 => ' million ', 3 => ' billion ', 4 => ' trillion ' }
    place_counter = 0
    
    while my_string.length > 0
      chars = my_string.split("")
      temp_str =  chars.pop(3).join("")
      my_string = chars.join("")
      
      final_string.prepend(in_words_step(temp_str) + group_place[place_counter]) unless temp_str == '000'
      place_counter += 1
    end
    
    final_string
  end
  
  def in_words_step(str)
    str = str.rjust(3, '0')
    output_string = ''
    ones = { 1 => 'one', 
              2 => 'two',
              3 => 'three',
              4 => 'four',
              5 => 'five',
              6 => 'six',
              7 => 'seven',
              8 => 'eight',
              9 => 'nine'
            }
    teens = { 10 => 'ten',
              11 => 'eleven',
              12 => 'twelve',
              13 => 'thirteen',
              14 => 'fourteen',
              15 => 'fifteen',
              16 => 'sixteen',
              17 => 'seventeen',
              18 => 'eighteen',
              19 => 'nineteen'
            }
    tens = { 2 => 'twenty',
              3 => 'thirty',
              4 => 'fourty',
              5 => 'fifty',
              6 => 'sixty',
              7 => 'seventy',
              8 => 'eighty',
              9 => 'ninety'
            }
    str.split('').each_with_index do |el,idx|
      if el.to_i > 0
        if idx == 0
          output_string << ones[el.to_i] + ' hundred '
        elsif idx == 1
          if el.to_i == 1
            temp_num = ''
            temp_num << el << str[2]
            return output_string + teens[temp_num.to_i]
          else
            output_string << tens[el.to_i]
            output_string << " " if str[2].to_i!= 0 
          end
        else
          output_string << ones[el.to_i]
        end
      end
    end
    output_string
  end
end

puts 1888259040036.in_words
puts 1_000_000_000_001.in_words
puts 15.in_words
puts 512.in_words
puts 10_000_001.in_words