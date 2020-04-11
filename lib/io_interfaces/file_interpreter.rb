require 'json'
require_relative '../custom_exceptions/end_of_input_error'
require_relative'./interpreter'

class FileInterpreter < Interpreter
  def initialize(filename)
    file = File.read(filename)
    @data_hash = JSON.parse(file)
  end

  def get_grid_size
    @data_hash["grid"].values.join(' ')
  end

  def get_rover_details
    rover = @data_hash["rovers"].shift
    raise EndOfInputError if rover.nil?
    start_position = [rover["initial_x"], rover["initial_y"], rover["orientation"]].join(' ')
    return start_position, rover["move_instructions"], rover["name"]
  end
end