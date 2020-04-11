require_relative './validations/validation'
require_relative './custom_exceptions/grid_initialization_error'

class Grid
  LOWER_INDEX = 0

  include Validation

  attr_reader :maximum_x_coord, :maximum_y_coord, :minimum_x_coord, :minimum_y_coord, :placed_rovers

  def initialize(x, y)
    @maximum_x_coord = x
    @maximum_y_coord = y
    @minimum_x_coord = @minimum_y_coord = Grid::LOWER_INDEX
    @placed_rovers = []
    unless valid?
      raise ::GridInitializationError, errors.values.join(' ')
    end
  end

  def unregister_rover!(rover)
    @placed_rovers.delete(rover)
  end

  def reserve_position!(rover)
    @placed_rovers << rover
  end
end