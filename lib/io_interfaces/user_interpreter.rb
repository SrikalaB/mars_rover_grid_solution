require_relative './interpreter'
require_relative '../custom_exceptions/end_of_input_error'

class UserInterpreter < Interpreter
  def get_grid_size
    print "Enter the uppermost right corner coordinates of the plateau grid. (Example input: 7 7):\n"
    gets.strip
  end

  def get_rover_details
    print "\nEnter the start postion and orientation of the rover you want to control (Example input: 2 2 N):\n"
    print "\s\s\s\s\s\s\s\s\s\sOR\nType 'exit' to quit program\n"
    start_position = gets.strip
    raise EndOfInputError if start_position == "exit"
    print "Enter instructions to move rover to desired location:\n"
    move_instructions = gets.strip
    return start_position, move_instructions
  end
end