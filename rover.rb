require 'matrix'
require './validation'

class Rover
  include Validation

  ORIENTATION_MAP = { 'S' => 180, 'E' => 90, 'N' => 0, 'W' => 270 }.freeze
  FORWARD_STEP_HELPER = { 'S' => Vector[0, -1], 'E' => Vector[1, 0], 'N' => Vector[0, 1], 'W' => Vector[-1, 0] }.freeze

  attr_reader :orientation, :position, :grid

  def initialize(x, y, initial_orientation, grid)
    @position = Vector[x, y]
    @orientation = initial_orientation
    @grid = grid
  end  

  def turn_left!
    turn!(-90)
  end

  def turn_right!
    turn!(90)
  end

  def move_forward!
    new_position = get_forward_postion
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
