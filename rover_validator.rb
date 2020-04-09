require './validate.rb'
require 'byebug'

class RoverValidator
  include Validate

  validates :orientaion,
            msg: "Invalid orientation, use N,S,E or W",
            with: proc { |rover| Rover::ORIENTATION_MAP.keys.include?(rover.orientation) }
  validates :position,
            msg: 'Cannot move to postion, out of bounds',
            with: :within_plateau_boundary
  validates :position,
            msg: 'Cannot move to position, already occupied!',
            with: :position_available

  private
  
  # @returns {Boolean}
  def within_plateau_boundary
    rover = self.object
    x,y = rover.position.to_a
    rover.grid.maximum_x_coord >= x && rover.grid.maximum_y_coord >=y && rover.grid.minimum_x_coord <= x && rover.grid.minimum_y_coord <= y
  end

  # @returns {Boolean}
  def position_available
    positions_arr = self.object.grid.occupied_coordinates.dup
    return true if positions_arr.empty?
    positions_arr.delete_at(positions_arr.index(self.object.position) || positions_arr.length)
    !positions_arr.include?(self.object.position)
  end

end
