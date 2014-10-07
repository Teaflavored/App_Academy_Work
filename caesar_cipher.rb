def caesar(word, shift)
  alphabet = ('a'..'z').to_a
  word.split('').map do |char|
    if alphabet.include? char
      alphabet[(alphabet.index(char)+shift) % 26]
    else
      char
    end
  end.join('')
end

puts caesar('hello hello', 3)