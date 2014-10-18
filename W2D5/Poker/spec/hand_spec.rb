#hand should be able to discard up to 3
#hand should be able to draw cards
#hand starts out with 5 cards
#hand should be able to compute biggest hand it forms
#hand should be able to tell if it beats another hand
#hand should hold an array of cards

require 'hand'

RSpec.describe Hand do
  let(:card1) { double("card1", value: 5, suit: :club) }
  let(:card2) { double("card2", value: 5, suit: :heart) }
  let(:card3) { double("card3", value: 10, suit: :heart) }
  let(:card4) { double("card4", value: 10, suit: :club) }
  let(:card5) { double("card5", value: 5, suit: :diamond) }
  let(:card6) { double("card6") }
  let(:deck) { double("deck", deal_cards: [card1,card2,card3,card4,card5]) }
  let(:deck2) { double("deck2", deal_cards: [card6]) } 
  subject(:hand) { Hand.new(deck) }
  
  
  describe "starting properties" do
    
    it "holds an array of cards" do
      expect(hand.cards).to be_an(Array)
    end
    
    it "contains 5 actual card objects" do
      expect(hand.cards).to include(card1)
    end
    
    it "starts with 5 cards" do
      expect(hand.size).to eq(5)
    end    
  end
  
  describe "discarding phase" do
    
    it "raises an error if you try to discard more than 3 cards" do
      expect { hand.discard([0,1,2,3]) }.to raise_error
    end
    
    it "discards unwanted cards" do
      hand.discard([0, 1, 2])
      expect(hand.size).to eq(2)
      expect(hand.cards).to include(card4)
      expect(hand.cards).not_to include(card3)
    end
    
    it "draws cards from deck" do
      expect(deck2).to receive(:deal_cards).with(1)
      
      hand.draw_from_deck(deck2, 1)
    end
    
    it "includes the drawn card" do
      hand.draw_from_deck(deck2, 1)
      
      expect(hand.cards).to include(card6)
    end
  end
  
  #straight flush
  let(:card6) { double("card", value: 2, suit: :club) }
  let(:card7) { double("card", value: 3, suit: :club) }
  let(:card8) { double("card", value: 4, suit: :club) }
  let(:card9) { double("card", value: 5, suit: :club) }
  let(:card10) { double("card", value: 6, suit: :club) }
  
  
  #royal flush
  let(:card11) { double("card", value: 10, suit: :club) }
  let(:card12) { double("card", value: 11, suit: :club) }
  let(:card13) { double("card", value: 12, suit: :club) }
  let(:card14) { double("card", value: 13, suit: :club) }
  let(:card15) { double("card", value: 14, suit: :club) }
  
  #fours
  let(:card16) { double("card", value: 10, suit: :club) }
  let(:card17) { double("card", value: 10, suit: :club) }
  let(:card18) { double("card", value: 10, suit: :club) }
  let(:card19) { double("card", value: 10, suit: :club) }
  let(:card20) { double("card", value: 14, suit: :club) }
  
  #flush
  let(:card21) { double("card", value: 9, suit: :club) }
  let(:card22) { double("card", value: 10, suit: :club) }
  let(:card23) { double("card", value: 11, suit: :club) }
  let(:card24) { double("card", value: 3, suit: :club) }
  let(:card25) { double("card", value: 7, suit: :club) }
  
  #straight
  let(:card26) { double("card", value: 2, suit: :club) }
  let(:card27) { double("card", value: 3, suit: :heart) }
  let(:card28) { double("card", value: 4, suit: :club) }
  let(:card29) { double("card", value: 5, suit: :club) }
  let(:card30) { double("card", value: 6, suit: :club) }
  
  #threes
  let(:card31) { double("card", value: 10, suit: :club) }
  let(:card32) { double("card", value: 10, suit: :heart) }
  let(:card33) { double("card", value: 10, suit: :club) }
  let(:card34) { double("card", value: 5, suit: :club) }
  let(:card35) { double("card", value: 6, suit: :club) }
  
  #twopair
  let(:card36) { double("card", value: 10, suit: :club) }
  let(:card37) { double("card", value: 10, suit: :heart) }
  let(:card38) { double("card", value: 5, suit: :club) }
  let(:card39) { double("card", value: 5, suit: :club) }
  let(:card40) { double("card", value: 8, suit: :club) }
  
  #twopairs2
  let(:card51) { double("card", value: 10, suit: :club) }
  let(:card52) { double("card", value: 10, suit: :heart) }
  let(:card53) { double("card", value: 5, suit: :club) }
  let(:card54) { double("card", value: 5, suit: :club) }
  let(:card55) { double("card", value: 6, suit: :club) }
  
  #pair
  let(:card41) { double("card", value: 10, suit: :club) }
  let(:card42) { double("card", value: 10, suit: :heart) }
  let(:card43) { double("card", value: 7, suit: :club) }
  let(:card44) { double("card", value: 5, suit: :club) }
  let(:card45) { double("card", value: 6, suit: :club) }
  
  #pair2
  let(:card56) { double("card", value: 10, suit: :club) }
  let(:card57) { double("card", value: 10, suit: :heart) }
  let(:card58) { double("card", value: 7, suit: :club) }
  let(:card59) { double("card", value: 5, suit: :club) }
  let(:card60) { double("card", value: 8, suit: :club) }
  
  #pair3
  let(:card61) { double("card", value: 11, suit: :club) }
  let(:card62) { double("card", value: 11, suit: :heart) }
  let(:card63) { double("card", value: 7, suit: :club) }
  let(:card64) { double("card", value: 5, suit: :club) }
  let(:card65) { double("card", value: 8, suit: :club) }
  
  #mixed
  let(:card46) { double("card", value: 11, suit: :club) }
  let(:card47) { double("card", value: 10, suit: :heart) }
  let(:card48) { double("card", value: 7, suit: :club) }
  let(:card49) { double("card", value: 5, suit: :club) }
  let(:card50) { double("card", value: 6, suit: :club) }
  
  describe "self worth" do
    
    it "correctly determines a full house" do
      expect(hand.worth).to eq(:fullhouse)
    end
    
    it "correctly determines a straight flush" do
      hand.cards = [card6, card7, card8, card9, card10]
      expect(hand.worth).to eq(:straight_flush)
    end
  
    it "correctly determines a royal flush" do
      hand.cards = [card11, card12, card13, card14, card15]
      expect(hand.worth).to eq(:royal_flush)
    end 
    
    it "correctly determines a four of a kind" do
      hand.cards = [card16, card17, card18, card19, card20]
      expect(hand.worth).to eq(:fours)
    end
    
    it "correctly determines a flush" do
      hand.cards = [card21, card22, card23, card24, card25]
      expect(hand.worth).to eq(:flush)
    end
    
    it "correctly determines a straight" do
      hand.cards = [card26, card27, card28, card29, card30]
      expect(hand.worth).to eq(:straight)
    end
    
    it "correctly determines a three of a kind" do
      hand.cards = [card31, card32, card33, card34, card35]
      expect(hand.worth).to eq(:threes)
    end
    
    it "correctly determines a two pair" do
      hand.cards = [card36, card37, card38, card39, card40]
      expect(hand.worth).to eq(:twopair)
    end
   
    it "correctly determines a pair" do
      hand.cards = [card41, card42, card43, card44, card45]
      expect(hand.worth).to eq(:pair)
    end
    
    it "correctly determines a pair" do
      hand.cards = [card46, card47, card48, card49, card50]
      expect(hand.worth).to eq(:mixed)
    end
  end
  
  
  
  describe "value comparison" do
    let(:hand1) { Hand.new(deck) }
    let(:hand2) { Hand.new(deck) }
    
    it "correctly determines easy comparison" do
      hand1.cards = [card16, card17, card18, card19, card20]
      hand2.cards = [card31, card32, card33, card34, card35]

      expect(hand1.beats?(hand2)).to be true
      expect(hand2.beats?(hand1)).not_to be true
    end
    
    it "correctly determines straght beats pair" do
      hand1.cards = [card26, card27, card28, card29, card30]  
      hand2.cards = [card36, card37, card38, card39, card40]
      
      expect(hand1.beats?(hand2)).to be true
    end
    
    it "correctly determines winner when hand level is two pair" do
      hand1.cards = [card36, card37, card38, card39, card40]
      hand2.cards = [card51, card52, card53, card54, card55]
      
      expect(hand1.beats?(hand2)).to be true
    end
    
    it "correctly determines winner when hand level is pair" do
      hand1.cards = [card41, card42, card43, card44, card45]
      hand2.cards = [card56, card57, card58, card59, card60]
      
      expect(hand2.beats?(hand1)).to be true
    end
    
    it "correctly determines winner when one pair is bigger than other pair" do
      hand1.cards = [card61, card62, card63, card64, card65]
      hand2.cards = [card56, card57, card58, card59, card60]
      
      expect(hand1.beats?(hand2)).to be true
    end
  end
  
end