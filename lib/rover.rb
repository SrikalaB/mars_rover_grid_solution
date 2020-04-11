require 'matrix'
require './validation'
require './move_not_permitted_error'
require './rover_initialization_error'

class Rover
  include Validation

  ORIENTATION_MAP = { 'S' => 180, 'E' => 90, 'N' => 0, 'W' => 270 }.freeze
  FORWARD_STEP_HELPER = { 'S' => Vector[0, -1], 'E' => Vector[1, 0], 'N' => Vector[0, 1], 'W' => Vector[-1, 0] }.freeze

  attr_reader :orientation, :position, :grid, :name

  def initialize(x, y, initial_orientation, grid, rover_name = nil)
    @position = Vector[x, y]
    @orientation = initial_orientation
    @grid = grid
    @name = rover_name
    unless valid?
      raise RoverInitializationError, errors.values.join(' ')
    end
    grid.reserve_position!(self)
  end  

  def turn_left!
    turn!(-90)
  end

  def turn_right!
    turn!(90)
  end

  def move_forward!
    old_position = @position
    @position = get_forward_postion
    unless valid?
      errors = self.errors.values.join(' ')
      @position = old_position
      raise MoveNotPermittedError, errors
    end
  end

  private
    
    # @returns {Integer} - represents degree of the orientation
    def orientation_degree
      ORIENTATION_MAP[@orientation]
    end

    # @param {Integer} - represents degrees of a circle
    # @returns {String} - indicates current orientation direction of rover - N, S, E or W
    def turn!(degrees)
      new_degree = (orientation_degree + degrees) % 360
      segment_size = 360 / ORIENTATION_MAP.size
      @orientation = ORIENTATION_MAP.key((((new_degree + (segment_size / 2)) % 360) / segment_size) * 90)
    end
    
    # @returns {Array} - represents x,y co-ordinates on the grid ahead of current position
    def get_forward_postion
      @position + FORWARD_STEP_HELPER[@orientation]
    end
end
