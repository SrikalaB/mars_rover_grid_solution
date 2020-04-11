class Interpreter
  
  def exit_with_grid_creation_failure(errors = nil)
    print "Script Aborted!! Grid Creation Failed!!!\n"
    print "Error: #{errors}\n" if !errors.nil?
    exit
  end

  def print_rover_creation_failure(errors = nil)
    print "Rover movement to start position failed!!!\n"
    print "Recheck co ordinates and orientation\n"
    print "Error: #{errors}\n" if !errors.nil?
  end

  def print_rover_movement_failure(errors = nil)
    print "Rover failed to move as per instruction!!!\n"
    print "Error: #{errors}\n" if !errors.nil?
  end

  def print_positions_on_grid(grid_interface)
    rover_positions = grid_interface.get_rover_positions
    print "\nThe final rover positions are:\n#{rover_positions}\n" if !rover_positions.empty?
  end
end