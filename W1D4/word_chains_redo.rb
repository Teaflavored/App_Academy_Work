class WordChains
  def initialize(filename)
    @dictionary = load_dictionary(filename)
    @current_words = []
    @all_seen_words = Hash.new(nil)
  end
  
  def load_dictionary(filename)
    File.readlines(filename).map(&:chomp)
  end
  
  def one_different(word)
    #returns all words that are one letter different from the current word
    new_dic = correct_word_length(word)
    new_dic.select do |dic_word|
      differences_count = 0
      dic_word.split("").each_index do |idx|
        differences_count += 1 if word[idx] != dic_word[idx]
      end
      differences_count == 1 ? true : false
    end
  end
  
  def correct_word_length(word)
    #returns all the words from dictionary that are same length as the given word
    length = word.length
    @dictionary.select { |word| word.length == length}
  end
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_list = one_different(word)
      adjacent_list.each do |adjacent_word|
        if !@all_seen_words.keys.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = word
        end
      end
    end
    new_current_words
  end
  
  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil
    until @current_words.empty? || @all_seen_words.keys.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words.dup
    end
    build_path(target)
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

test = WordChains.new("dictionary.txt")
test.run("rook","buck")