require 'rspec'
require 'board.rb'
require 'spec_helper.rb'


describe Board do
  let(:o_board) { Board.new }
  
  describe "Grid" do
    it "should be able to access grid elements with row, col arrays" do
      expect(o_board[[0,0]]).to be_nil
      expect(o_board[[0,1]]).not_to be_nil
    end
    
    it "should have the right dimensions of 8 x 8" do
      expect(o_board.instance_variable_get("@grid").count).to eq(8)
      expect(o_board.instance_variable_get("@grid").first.count).to eq(8)
    end
  end
  
  describe "Dup method" do
    let(:new_board) { o_board.dup }
    it "should return a brand new board" do
      expect(new_board.object_id).not_to eq(o_board.object_id)
    end
    
    it "should return brand new pieces" do
      expect(new_board[[7,0]].object_id).not_to eq(o_board[[7,0]].object_id)
    end
    
    describe "duped pieces" do
      let(:n_piece) { new_board[[7,0]] }
      it "should contain a reference to new_board" do
        expect(n_piece.instance_variable_get("@board").object_id).to eq(new_board.object_id)
      end
    end
  end
  
end