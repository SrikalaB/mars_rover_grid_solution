require './validation'

class Grid
  LOWER_INDEX = 0

  include Validation

  attr_reader :maximum_x_coord, :maximum_y_coord, :minimum_x_coord, :minimum_y_coord

  def initialize(x, y)
    @maximum_x_coord = x
    @maximum_y_coord = y
    @minimum_x_coord = @minimum_y_coord = Grid::LOWER_INDEX
  end
end