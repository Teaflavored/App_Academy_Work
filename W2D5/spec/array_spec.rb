require 'rspec'
require 'spec_helper'
require 'array'

RSpec.describe "Array" do
  describe "remove dups" do
    it "should remove duplicate entries from array" do
      expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
    end
  end
  
  describe "two sum" do
    it "should find pairs of positions where elements at those positions add to 0" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end
  
  
  describe "transpose" do
    it "should convert rows into columns" do 
     expect([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].my_transpose).to eq([[0, 3, 6],
     [1, 4, 7],
     [2, 5, 8]]) 
    end
  end
  
  describe "stock picker" do
    it "should give the most profitable pair of days" do
      expect([1, 5, 10, 55, 25, 23, 10].stock_picker).to eq([0, 3])
      expect([22,11,34,55,77,22,9].stock_picker).to eq([1, 4])
    end
  end
end