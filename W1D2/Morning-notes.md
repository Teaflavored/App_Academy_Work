Keep methods to around 10 lines, just do one thing
don't use globals ($variables)
spaces around operators
space after comma
if condition is too complex, move it into a method of its own
make sure code isn't dependent on a condition
descriptive variable names, shouldn't need context to figure out what a variable means
don't overuse comments on pointless things
indentation makes things look nicer and easier to read


for prompts

def choose_tower(prompt)
  loop do
    puts prompt
    temp_tower = gets.chomp.to_i - 1
    if temp_tower.between?(0,2)
      return temp_tower
    end
    puts "invalid from_tower tower"
  end
end


functions should raise exceptions if not within excepted performance