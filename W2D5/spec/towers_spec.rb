require 'rspec'
require 'towers'

RSpec.describe "Towers Of Hanoi" do
  subject(:game) { TowersOfHanoi.new }
  
  describe "setting up towers" do
    it "builds an array of 3 arrays" do
      expect(game.towers).to be_an(Array)
      expect(game.towers.count).to eq(3)
      expect(game.towers[0]).to be_an(Array)
    end
    
    it "fills in pieces on first tower" do
      expect(game.towers[0]).to eq([3, 2, 1])
    end
      
  end
  
  describe "game over" do

    it "recognizes correct game over" do
      game.towers = [[], [3,2,1], []]
      expect(game.game_over?).to be(true)
    end
    
    it "does not return true for non-game-over state" do
      game.towers = [[1], [3, 2], []]
      expect(game.game_over?).not_to be(true)
    end
  end
  
  describe "moving pieces" do
    
    it "should accept a legal move" do
      expect { game.move_piece(0, 1) }.not_to raise_error
    end
    
    it "should raise IllegalMoveError when attemping an illegal move" do
      game.towers =[[3, 2], [1], []]
      expect{ game.move_piece(0, 1) }.to raise_error
    end
    
    it "should complete a move" do
      game.move_piece(0,1)
      expect(game.towers).to eq([[3, 2], [1], []])
    end
  end

end