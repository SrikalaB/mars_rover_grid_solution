require 'spec_helper'
require 'grid'
require 'rover'

describe 'grid' do
  let!(:grid) { Grid.new(5, 5) }

  context 'invalid' do
    it 'should accept only positive integers for grid coordinates' do
      expect{ Grid.new(-5, -5) }.to raise_error(::GridInitializationError)
    end

    it 'should not have invalid rovers registered' do
      expect {  Rover.new(2, 3, 'O', grid) rescue nil }.to_not change(grid, :placed_rovers)
    end
  end
  
  context 'valid' do
    let!(:rover) { Rover.new(2, 3, 'N', grid) }
  
    it 'should create valid Grid with positive integer coordinates' do
      expect(grid).to be_instance_of(Grid)
      expect(grid.valid?).to be true
    end

    it 'should allow a grid with 0,0 as maximum x and y coordinates' do
      grid = Grid.new(0, 0)
      expect(grid.valid?).to be true
    end

    it 'should implicitly set the minimum x and y coordinates' do
      expect(grid.minimum_x_coord).to be 0
      expect(grid.minimum_y_coord).to be 0
    end

    it 'should have all valid rovers registered' do
      expect(grid.placed_rovers).to include rover
    end
  end
end