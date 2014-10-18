require 'card'

RSpec.describe Card do
  subject(:card) { Card.new(14, :spade) }
  let(:card2) { Card.new(10, :heart) }
  let(:card3) { Card.new(10, :spade) }
  let(:card4) { Card.new(3, :diamond) }
  
  describe "initializing a card" do
    it "won't let you create invalid cards" do
      expect { Card.new(15, :spade) }.to raise_error InvalidCard
    end
  end
  
  describe "properties of a card" do
    it "lets you access properties of the card" do
      expect(card.value).to eq(14)
      expect(card.suit).to eq(:spade)
    end
  end
  
  describe "comparing cards" do
    
    it "correctly determines which card is bigger" do
      expect(card).to be > card2
      expect(card2).to be < card
    end 
    
    it "correctly determines 2 cards are equal value" do
      expect(card2).to be == card3
    end
    
  end
  
  describe "display cards" do
    
    it "gives a string of the card" do
      expect(card.to_s).to eq("Ace of Spades")
      expect(card2.to_s).to eq("Ten of Hearts")
      expect(card3.to_s).to eq("Ten of Spades")
      expect(card4.to_s).to eq("Three of Diamonds")
    end
    
  end
  
  
  
end