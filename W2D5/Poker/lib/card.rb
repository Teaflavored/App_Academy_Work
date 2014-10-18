class InvalidCard < StandardError; end

class Card
  include Comparable
  
  SUITS = [:heart, :spade, :club, :diamond]
  
  VALUE_STRINGS = {
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten",
    11 => "Jack",
    12 => "Queen",
    13 => "King",
    14 => "Ace"    
  }
  
  SUIT_STRINGS = {
    heart: "Hearts",
    spade: "Spades",
    club: "Clubs",
    diamond: "Diamonds"
  }
  
  attr_reader :value, :suit
  
  def initialize(value, suit)  
    raise InvalidCard.new unless value.between?(2,14) && SUITS.include?(suit)
    @value = value
    @suit = suit
  end
  
  def <=>(other_card)
    self.value <=> other_card.value
  end
  
  def to_s
    "#{VALUE_STRINGS[@value]} of #{SUIT_STRINGS[@suit]}"
  end
  
end