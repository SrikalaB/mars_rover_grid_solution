require './validate.rb'

class RoverValidator
  include Validate

  validates :orientaion,
            msg: "Invalid orientation, use N,S,E or W",
            with: proc { |rover| Rover::ORIENTATION_MAP.keys.include?(rover.orientation) }
  validates :position,
            msg: 'Cannot move to postion, out of bounds',
            with: :within_plateau_boundary

  private
  
  def within_plateau_boundary
    rover = self.object
    x,y = rover.position.to_a
    rover.grid.maximum_x_coord >= x && rover.grid.maximum_y_coord >=y && rover.grid.minimum_x_coord <= x && rover.grid.minimum_y_coord <= y
  end

end
