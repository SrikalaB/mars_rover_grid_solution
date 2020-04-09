require './validate.rb'

class GridValidator
  include Validate

  validates :maximum_x_coord,
            msg: "Invalid input. Only non negative integers are accepted",
            with: proc { |grid| grid.maximum_x_coord.is_a?(Integer) && grid.maximum_x_coord >= 0 }
  validates :maximum_y_coord,
            msg: "Invalid input. Only non negative integers are accepted",
            with: proc { |grid| grid.maximum_y_coord.is_a?(Integer) && grid.maximum_y_coord >= 0 }
end