require 'player'

RSpec.describe Player do
  let(:deck) { double("deck") }
  let(:game) { double("game", pot: 0, :pot= => 0) }
  subject(:player) { Player.new("bob", 10_000, game, deck) }

  describe "player instantiation" do
    
    it "has a name" do
      expect(player.name).to eq("bob")
    end
    
    it "has a bankroll" do
      expect(player.bank).to eq(10_000)
    end
    
    it "should not be in round" do
      expect(player.in_round).to be(nil)
    end
    
  end
  
  describe "discarding phase" do
    
    it "asks player what to discard" do
      expect(player.hand).to receive(:discard).with([0, 1, 2])
      expect(player.hand).to receive(:draw_from_deck).with(deck, 3) 
      
      player.discard_turn([0,1,2], deck)
    end
    
  end
  
  describe "folding" do
    
    it "puts player out of round" do
      player.fold!
      
      expect(player.in_round).to be(false)
    end
  end
  
  describe "betting phase" do
  
    it "should raise error if user tries to bet more money than he has" do
      expect { player.bet_amt(10001) }.to raise_error
    end
    
    it "bets the right amount of money" do
      player.bet_amt(500)
      
      expect(player.bank).to eq(9500)
    end
    
    it "can receive winnings" do
      player.receive_amt(1000)
      
      expect(player.bank).to eq(11000)
    end
    
    it "raises an error if you call with not enough money" do
      expect { player.call(10001) }.to raise_error
    end
    
    it "can call other bets" do
      player.call(10000)
      
      expect(player.bank).to eq(0)
    end
    
  end
end