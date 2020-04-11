require 'optparse'
require './grid_interface'
require './file_interpreter'
require './user_interpreter'
require 'byebug'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby rover_control.rb -i\nUsage: ruby rover_control.rb -f=/path/to/jsonfile"

  opts.on("-i", "--interactive", "Run interactively to enter input") do |i|
    options[:interactive_mode] = true
  end

  opts.on("-f", "--file=FILE", "Input json file with instructions.") do |f|
    options[:filename] = f
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

if options.empty? || (!options[:interactive_mode].nil? && !options[:filename].nil?)
  puts "Usage: ruby rover_control.rb -i\nUsage: ruby rover_control.rb -f=/path/to/jsonfile"
end

begin
  interpreter = options[:interactive_mode] ? UserInterpreter.new : FileInterpreter.new(options[:filename])
  coordinates = interpreter.get_grid_size
  grid_interface = GridInterface.new(coordinates)
  while 1
    begin
      start_position, move_instructions, rover_name = interpreter.get_rover_details
      placed_rover = grid_interface.initialize_rover(start_position, rover_name)
      rover = grid_interface.move_rover(move_instructions, placed_rover)
      print "----Position of rover after move is: #{rover.position[0]} #{rover.position[1]} #{rover.orientation} #{rover.name}----\n\n"
    rescue RoverInitializationError => e
      interpreter.print_rover_creation_failure(e.message)
      next
    rescue MoveNotPermittedError => e
      interpreter.print_rover_movement_failure(e.message)
      next
    rescue EndOfInputError
      interpreter.print_positions_on_grid(grid_interface)
      exit
    end
  end
rescue GridInitializationError => e
  interpreter.exit_with_grid_creation_failure(e.message)
rescue StandardError => e
  print "An Error Has occured! #{e.message}"
end

