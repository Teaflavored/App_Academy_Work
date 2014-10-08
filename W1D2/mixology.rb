require 'debugger'
class Mixology
  attr_reader :ingredient_array, :alcohol_array, :mixer_array
  
  def initialize(arr)
    @ingredient_array = arr
    @alcohol_array = get_alcohols
    @mixer_array = get_mixers
  end
  
  def reset_array
    @alcohol_array = get_alcohols
    @mixer_array = get_mixers
  end
  
  def get_alcohols
    [].tap do |alcohols|
      ingredient_array.each_index do |i|
        alcohols << ingredient_array[i].first
      end
    end
  end
  
  def get_mixers
    [].tap do |mixers|
      ingredient_array.each_index do |i|
        mixers << ingredient_array[i].last
      end
    end
  end
  
  def remix
    
    @alcohol_array = get_alcohols
    @mixer_array = get_mixers
    
    [].tap do |final_mixed|
      until final_mixed.length == get_length
        current_pair = create_mixed_pair
        if !ingredient_array.include?(current_pair)
          final_mixed << current_pair
          delete_pair(current_pair)
        else
          p current_pair
          p create_mixed_pair
        end
      end
    end
    
  end
  
  def delete_pair(pair)
    alcohol_array.delete(pair.first)
    mixer_array.delete(pair.last)
  end
  
  def create_mixed_pair
    [shuffled_alcohol.first, shuffled_mixer.first]
  end
  
  def get_length
    ingredient_array.length
  end
  
  def shuffled_alcohol
    alcohol_array.shuffle
  end
  
  def shuffled_mixer
    mixer_array.shuffle
  end
  
end
