require './grid'
require './grid_initialization_error'
require './rover_initialization_error'
require './rover'
require 'byebug'

class InstructionParser
  def self.create_grid(coordinates)
    raise GridInitializationError, 'Invalid input' unless coordinates.match(/^[0-9]+\s+[0-9]+$/)
    x, y = coordinates.split(' ')
    grid = Grid.new(x.to_i, y.to_i)
    unless grid.valid?
      raise GridInitializationError, grid.errors.values.join(' ')
    end
    return grid
  end

  def self.initialize_rover(start_position, grid)
    raise RoverInitializationError, 'Invalid input' unless start_position.match(/^[0-9]+\s+[0-9]+\s+N|S|E|W$/)
    x, y, o = start_position.split(' ')
    rover = Rover.new(x.to_i, y.to_i, o, grid)
    unless rover.valid?
      grid.unregister_rover!(rover)
      raise RoverInitializationError, rover.errors.values.join(' ')
    end
    return rover
  end

  def self.move_rover(instructions, rover)
    instructions_array = instructions.split(' ')
    raise MoveNotPermittedError, 'Invalid Movement instructions' unless instructions_array.uniq.reject { |l| l == 'L' || l == 'M' || l == 'R'}.empty?
    instructions_array.each do |instruction|
      case instruction
      when 'L'
        rover.turn_left!
      when 'R'
        rover.turn_right!
      when 'M'
        rover.move_forward!
      else
        raise MoveNotPermittedError, "Unable to understand movement instructions"
      end
    end
    raise MoveNotPermittedError, rover.errors.values.join(' ') unless rover.valid?
    return rover
  end
end