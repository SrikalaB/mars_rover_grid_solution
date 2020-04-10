require 'optparse'
require './grid_interface'
require './grid'
require 'json'
require 'byebug'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby rover_control.rb -i\nUsage: ruby rover_control.rb -f=/path/to/jsonfile"

  opts.on("-i", "--interactive", "Run interactively to enter input") do |i|
    options[:interactive_mode] = i
  end

  opts.on("-f", "--file=FILE", "Input json file with instructions.") do |f|
    options[:filename] = f
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

if options.empty?
  puts "Usage: ruby rover_control.rb -i\nUsage: ruby rover_control.rb -f=/path/to/jsonfile"
end

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

if !options[:interactive_mode].nil?
  begin
    print "Enter the uppermost right corner coordinates of the plateau grid. (Example input: 7 7):\n"
    coordinates = gets.strip
    grid_interface = GridInterface.new(coordinates)
    counter = 0
    while 1
      counter += 1
      if counter > 1
        print "\nWould you like to continue? Type 'yes' or 'no': "
        continue = gets.strip
        if !(continue == "yes")
          print_positions_on_grid(grid_interface)
          exit
        end
      end
      begin
        print "Enter the start postion and orientation of the rover you want to control. (Example input: 2 2 N):\n"
        start_position = gets.strip
        rover = grid_interface.initialize_rover(start_position)
        print "Enter instructions to move rover to desired location:\n"
        move_instructions = gets.strip
        rover = grid_interface.move_rover(move_instructions, rover)
        print "----Position of rover after move is: #{rover.position[0]} #{rover.position[1]} #{rover.orientation}----\n\n"
      rescue RoverInitializationError => e
        print_rover_creation_failure(e.message)
        next
      rescue MoveNotPermittedError => e
        print_rover_movement_failure(e.message)
        next
      end
    end
  rescue GridInitializationError => e
    exit_with_grid_creation_failure(e.message)
  end
end


if !options[:filename].nil?
  begin
    file = File.read(options[:filename])
    data_hash = JSON.parse(file)
    coordinates = data_hash["grid"].values.join(' ')
    grid_interface = GridInterface.new(coordinates)
    data_hash["rovers"].each do |rover|
      print "\nProcessing next rover #{rover["name"]}........\n"
      begin
        start_position = [rover["initial_x"], rover["initial_y"], rover["orientation"]].join(' ')
        placed_rover = grid_interface.initialize_rover(start_position, rover["name"])
        move_instructions = rover["move_instructions"]
        grid_interface.move_rover(move_instructions, placed_rover)
      rescue RoverInitializationError => e
        print_rover_creation_failure(e.message)
        next
      rescue MoveNotPermittedError => e
        print_rover_movement_failure(e.message)
        next
      end
    end
    print_positions_on_grid(grid_interface)
  rescue GridInitializationError => e
    exit_with_grid_creation_failure(e.message)
  end
end

