require_relative './grid'
require_relative './custom_exceptions/grid_initialization_error'
require_relative './custom_exceptions/rover_initialization_error'
require_relative './rover'

class GridInterface
  def initialize(coordinates)
    raise GridInitializationError, 'Invalid input' unless coordinates.match(/^[0-9]+\s+[0-9]+$/)
    x, y = coordinates.split(' ')
    grid = Grid.new(x.to_i, y.to_i)
    @grid = grid
  end

  def initialize_rover(start_position, rover_name = nil)
    raise RoverInitializationError, 'Invalid input' unless start_position.match(/^[0-9]+\s+[0-9]+\s+N|S|E|W$/)
    x, y, o = start_position.split(' ')
    Rover.new(x.to_i, y.to_i, o, @grid, rover_name)
  end

  def move_rover(instructions, rover)
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
    return rover
  end

  def get_rover_positions
    final_postions = []
    @grid.placed_rovers.each do |rover|
      final_postions << "#{rover.position[0]} #{rover.position[1]} #{rover.orientation} #{rover.name}"
    end
    final_postions.join("\n")
  end
end