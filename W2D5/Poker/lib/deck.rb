require_relative "card.rb"
class Deck
  attr_reader :cards
  
  def initialize
    @cards = new_deck
  end
  
  def count
    @cards.count
  end
  
  def new_deck
    deck = []
    Card::SUITS.each do |suit|
      (2..14).each do |value|
        deck << Card.new(value, suit)
      end
    end
    
    deck
  end
  
  def return_cards(cards)
    @cards.concat(cards)
  end
  
  def deal_cards(n)
    raise "not enough cards" if n > count
    @cards.pop(n)
  end
  
  def shuffle!
    @cards.shuffle!
  end
end