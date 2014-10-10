require 'set'

class WordChainer
  attr_reader :dictionary
  
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
    @current_words = []
    @all_seen_words = Hash.new(nil)
  end
  
  
  def adjacent_words(word)
    correct_length_words = correct_length(word)
    correct_length_words.select { |adj_word| !more_than_one_difference?(adj_word,word) }
  end
  
  def correct_length(word)
    @dictionary.select { |dict_word| dict_word.length == word.length }
  end
  
  def more_than_one_difference?(word1,word2)
    differences = 0
    word1.split("").each_index do |idx|
      differences += 1 if word1[idx] != word2[idx]
    end
    return true if differences > 1
    return false
  end
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_list = adjacent_words(word)
      adjacent_list.each do |adjacent_word|
        if !@all_seen_words.keys.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = word
        end
      end
    end
    new_current_words
  end
  
  def run(source,target)
    @current_words << source
    @all_seen_words[source] = nil
    
    until @current_words.empty? || @all_seen_words.keys.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words.dup
    end
    begin
      build_path(target)
    rescue 
      puts "No chain can be found, the dictionary is not expansive enough"
      exit
    end
  end
  
  def build_path(target)
    path = [] << target
    search = @all_seen_words[target]
    until search.nil?
      path << search
      search = @all_seen_words[search]
    end
    raise if path.length == 1
    p path.reverse
  end
end


test = WordChainer.new("dictionary.txt")
test.run("rook","buck")

#create array
#word_array. each index |i|, 
#create rejex
#correct_words << match words in dictionary with regex