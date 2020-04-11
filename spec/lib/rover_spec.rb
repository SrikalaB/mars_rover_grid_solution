require 'spec_helper'
require 'grid'
require 'rover'

describe 'rover' do
  context 'invalid' do
    let!(:grid) { Grid.new(5, 5) }
    let!(:rover) { Rover.new(2, 3, 'S', grid) }

    it 'does not contain only positive integers for initial position' do
      expect { Rover.new(-2, -2, 'N', grid) }.to raise_error(::RoverInitializationError)
    end

    it 'does not contain occupy position within the grid' do
      expect { Rover.new(2, 6, 'N', grid) }.to raise_error(::RoverInitializationError)
    end

    it 'does not contain only whitelisted orientations' do
      expect { Rover.new(3, 3, 'J', grid) }.to raise_error(::RoverInitializationError).with_message(/Invalid orientation/)
    end

    it 'does not reserve place on grid when invalid' do
      expect {  Rover.new(2, 4, 'K', grid) rescue nil }.to_not change(grid, :placed_rovers)
    end

    it 'does not occupy place used up by another rover' do
      expect { Rover.new(2, 3, 'N', grid) }.to raise_error(::RoverInitializationError).with_message(/already occupied/)
    end
  end
  
  context 'valid' do
    let!(:grid) { Grid.new(5, 5) }
    let!(:rover) { Rover.new(2, 3, 'S', grid) }

    it 'should have positive integer coordinates and correct orientation' do
      expect(rover.valid?).to be true
    end

    it 'should be associated with a grid' do
      expect(rover.grid).to be_instance_of(Grid)
    end

    it 'should be registered on the grid' do
      expect(grid.placed_rovers).to include rover
    end

    it 'can have a name optionally' do
      expect(Rover.new(1, 1, 'S', grid, 'myrover').name).to eq 'myrover'
    end
  end

  context 'movement' do
    let!(:grid) { Grid.new(5, 5) }

    it 'should change direction on turn' do
      rover_1 = Rover.new(2, 3, 'S', grid)
      rover_1.turn_left!
      expect(rover_1.orientation).to eq 'E'
      rover_1.turn_left!
      expect(rover_1.orientation).to eq 'N'
      rover_1.turn_left!
      expect(rover_1.orientation).to eq 'W'
      rover_1.turn_left!
      expect(rover_1.orientation).to eq 'S'
      rover_1.turn_right!
      expect(rover_1.orientation).to eq 'W'
      rover_1.turn_right!
      expect(rover_1.orientation).to eq 'N'
      rover_1.turn_right!
      expect(rover_1.orientation).to eq 'E'
      rover_1.turn_right!
      expect(rover_1.orientation).to eq 'S'
    end

    it 'should move in y axis when orientation is N or S' do
      rover_2 = Rover.new(0, 0, 'N', grid)
      rover_2.move_forward!
      expect(rover_2.position).to eq Vector[0,1]
      2.times { rover_2.turn_right! }
      rover_2.move_forward!
      expect(rover_2.position).to eq Vector[0,0]
    end
    
    it 'should move in x axis when orientation is W or E' do
      rover_2 = Rover.new(0, 0, 'E', grid)
      rover_2.move_forward!
      expect(rover_2.position).to eq Vector[1,0]
      2.times { rover_2.turn_right! }
      rover_2.move_forward!
      expect(rover_2.position).to eq Vector[0,0]
    end

    it 'should not move to a position already taken by another rover' do
      rover_3 = Rover.new(3, 4, 'S', grid)
      rover_4 = Rover.new(3, 3, 'E', grid)
      expect { rover_3.move_forward! }.to raise_error(MoveNotPermittedError)
    end

    it 'should not move out of the grid' do
      rover_5 = Rover.new(5, 5, 'E', grid)
      expect { rover_5.move_forward! }.to raise_error(MoveNotPermittedError)
    end
  end
end