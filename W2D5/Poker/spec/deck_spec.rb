require 'deck'

RSpec.describe Deck do
  subject(:deck) { Deck.new }
  
  
  #can return cards back to deck
  #deck can deal at most 5 at once
  
  describe "deck properties" do 
    it "has 52 cards" do
      expect(deck.count).to eq(52)
    end
    
    it "has array of cards" do
      expect(deck.cards).to be_an(Array)
    end
  end
  
  describe "shuffle deck" do
    it "shuffles the array of cards" do
      expect(deck.cards).to receive(:shuffle!)
      
      deck.shuffle!
    end 
  end
  
  describe "returning cards back to deck" do
    let(:card) { double("card", value: 16) }
    
    it "returns cards back to deck" do
      deck.return_cards([card])
      expect(deck.cards).to include(card)
    end
  end
  
  describe "dealing cards" do
    
    it "deals cards to hand" do
      deck.deal_cards(5)
      expect(deck.count).to eq(47)
    end
    
    it "raises error if not enough cards in deck" do
      expect { deck.deal_cards(53) }.to raise_error
    end
    
  end
  
end