require_relative 'deck.rb'


class Array
  def more_than?(other_arr)
    #only works on sorted arrays
    (self.length-1).downto(0).each do |idx|
      next if self[idx] == other_arr[idx]
      return true if self[idx] > other_arr[idx]
      return false if self[idx] < other_arr[idx] 
    end
  end
end


class Hand
  
  HAND_WORTH ={
    mixed: 0,
    pair: 1,
    twopair: 2,
    threes: 3,
    straight: 4,
    flush: 5,
    fullhouse: 6,
    fours: 7,
    straight_flush: 8,
    royal_flush: 9
    
  }
  
  attr_accessor :cards
  
  def initialize(deck)
    @deck = deck
    @cards = []
    draw_from_deck(deck, 5)
  end
  
  def size
    @cards.size
  end
  
  def draw_from_deck(deck, num)
    @cards += deck.deal_cards(num)
  end
  
  def to_s
    output_arr = []
    @cards.each do |card|
      output_arr << card.to_s
    end
    output_arr.join(", ") + ". Your hand's worth is #{worth.to_s}"
  end
  
  def discard(card_pos)
    raise "can't discard more than 3" if card_pos.count > 3
    @cards.reject!.with_index do |card, idx|
      card_pos.include?(idx)
    end
  end
  
  def beats_tie?(other_hand)
    #return true if hand is bigger than other if they're same level
    if royal_flush? || straight_flush? || flush? || straight?
      sorted_value_array.more_than?(other_hand.sorted_value_array)
    elsif worth == :mixed
      sorted_value_array.more_than?(other_hand.sorted_value_array)
    elsif four_of_a_kind || full_house || three_of_a_kind
      unique_hand_biggest > other_hand.unique_hand_biggest
    elsif two_pair
      if two_pair.sort.more_than?(other_hand.two_pair.sort)
        return true
      elsif two_pair.sort == other_hand.two_pair.sort
        our_val_array = sorted_value_array
        our_pairs = two_pair
        their_val_array = other_hand.sorted_value_array
        our_val_array.reject! { |value| our_pairs.include?(value) }
        their_val_array.reject! { |value| our_pairs.include?(value) }
        our_val_array.more_than?(their_val_array)
      else
        return false
      end
    else
      if self.pair.more_than?(other_hand.pair)
        return true
      elsif self.pair == other_hand.pair
        our_val_array = sorted_value_array
        our_pairs = self.pair
        their_val_array = other_hand.sorted_value_array
        our_val_array.reject! { |value| our_pairs.include?(value) }
        their_val_array.reject! { |value| our_pairs.include?(value) }
        our_val_array.more_than?(their_val_array)
      else
        return false
      end
    end
  end
  
  def beats?(other_hand)
    if HAND_WORTH[self.worth] == HAND_WORTH[other_hand.worth]
      beats_tie?(other_hand) 
    else
      HAND_WORTH[self.worth] > HAND_WORTH[other_hand.worth]
    end
  end
  
  def unique_hand_biggest
    four_of_a_kind || full_house || threes
  end
  
  def worth
    return :royal_flush if royal_flush?
    return :straight_flush if straight_flush?
    return :fours if four_of_a_kind
    return :fullhouse if full_house
    return :flush if flush?
    return :straight if straight?
    return :threes if three_of_a_kind
    return :twopair if two_pair
    return :pair if pair
    :mixed
  end
  
  def number_same_card
    count = Hash.new(0)
    sorted_value_array.each do |el|
      count[el] += 1
    end
    
    count
  end
  
  def four_of_a_kind
    number_same_card.key(4)
  end
  
  def three_of_a_kind
    number_same_card.key(3)
  end
  
  def full_house
    number_same_card.key(3) if three_of_a_kind && pair
  end
  
  def two_pair
    pairs = []
    number_same_card.each do |key, value|
      pairs << key if value == 2
    end
    
    return pairs if pairs.size == 2
    
    nil
  end
  
  def pair
    pairs = []
    number_same_card.each do |key, value|
      pairs << key if value == 2
    end
    
    return pairs if pairs.size == 1
    
    nil
  end
  
  def sorted_value_array
    result = []
    @cards.each do |card|
      result << card.value
    end
    result.sort
  end
  
  def straight?
    card_values = sorted_value_array
    if card_values[-1] == 14 && card_values.include?(4)
      card_values[-1] = 1
      card_values.sort!
    end
    card_values.each_index do |idx|
      next if idx == card_values.length - 1
      return false unless card_values [idx] + 1 == card_values[idx + 1]
    end
    
    true
  end
  
  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end
  
  def straight_flush?
    straight? && flush?
  end
  
  def royal_flush?
    straight? && flush? && 
    sorted_value_array.include?(13) && sorted_value_array.include?(14)
  end
  
end
