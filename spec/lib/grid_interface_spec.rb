require 'spec_helper'
require 'grid_interface'
require 'rover'
require 'grid'

describe 'grid_interface' do
  context 'invalid' do
    let!(:grid_interface) { GridInterface.new('7 7') }

    it 'should raise error when invalid grid input' do
      expect{ GridInterface.new('-5 -5') }.to raise_error(::GridInitializationError)
    end

    it 'should raise error when invalid rover input' do
      expect{ grid_interface.initialize_rover('8 8 K') }.to raise_error(::RoverInitializationError)
    end

    it 'should raise error when invalid instruction input' do
      rover = grid_interface.initialize_rover('2 2 N')
      expect{ grid_interface.move_rover('K', rover) }.to raise_error(MoveNotPermittedError)
    end
  end

  context 'valid' do
    let!(:grid_interface) { GridInterface.new('7 7') }

    it 'should accept valid grid coordinates to create grid' do
      expect{ GridInterface.new('5 5') }.not_to raise_error
    end

    it 'should accept valid rover coordinates to create rover' do
      expect{ grid_interface.initialize_rover('4 4 W') }.not_to raise_error
    end

    it 'should interpret move instructions correctly' do
      rover = grid_interface.initialize_rover('3 2 N')
      grid_interface.move_rover('L', rover)
      expect(rover.orientation).to eq 'W'
      grid_interface.move_rover('M', rover)
      expect(rover.orientation).to eq 'W'
      expect(rover.position).to eq Vector[2, 2]
      grid_interface.move_rover('R', rover)
      expect(rover.orientation).to eq 'N'
    end
  end

  context 'rover postions' do
    let!(:grid_interface) { GridInterface.new('7 7') }

    it 'should show all postions correctly' do
      rover = grid_interface.initialize_rover('3 2 N')
      grid_interface.move_rover('M', rover)
      rover2 = grid_interface.initialize_rover('5 6 N')
      expect(grid_interface.get_rover_positions).to include '3 3 N'
      expect(grid_interface.get_rover_positions).to include '5 6 N'
    end
  end
end
