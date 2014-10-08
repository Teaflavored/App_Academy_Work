class ShuffleReader
  attr_reader :filename
  def initialize 
    @filename = user_prompt
  end
  
  def user_prompt
    loop do 
      puts "What file do you want to shuffle? "
      input = gets.chomp
      return input if input.match(/\.txt\z/ ) || input.match(/\.rb\z/)
    end
  end
  
  def process_file
    lines = File.readlines(filename)
  end
  
  def shuffle_lines
    process_file.shuffle
  end
  
  def create_new_file_name
    "{#{filename}}-shuffled.txt"
  end
  
  def create_file
    File.open(create_new_file_name, 'w') do |file|
      shuffle_lines.each do |line|
        file.puts line.rstrip
      end
    end
  end
  
end


test = ShuffleReader.new
test.create_file

