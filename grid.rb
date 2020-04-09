require './validation'
require 'byebug'

class Grid
  LOWER_INDEX = 0

  include Validation

  attr_reader :maximum_x_coord, :maximum_y_coord, :minimum_x_coord, :minimum_y_coord, :occupied_coordinates

  def initialize(x, y)
    @maximum_x_coord = x
    @maximum_y_coord = y
    @minimum_x_coord = @minimum_y_coord = Grid::LOWER_INDEX
    @occupied_coordinates = []
  end
  
  # Reserves a position for the rover on the grid
  def register_rover(rover)
    rover.grid.occupied_coordinates << rover.position
  end

  def free_position!(coordinate_vector)
    @occupied_coordinates.delete(coordinate_vector) if !@occupied_coordinates.empty?
  end

  def reserve_position!(coordinate_vector)
    @occupied_coordinates << coordinate_vector
  end
end