H52WAD4gq32EmVaVvaa9
puts 'Hello World'
require './grid.rb'
require './rover.rb'

Dir["/path/to/directory/*.rb"].each {|file| require file }

plateau1 = Grid.new(5,6)

bot1 = Rover.new(4, 4,'N', plateau1)
bot1.turn_right!
if bot1.valid?
  puts 'yay'
else
  puts 'nay'
end
bot2 = Rover.new(4, 5,'N', plateau1)
bot3 = Rover.new(2,2, 'E', plateau1)
bot4 = Rover.new(2,2, 'E', plateau1)
bot_arr = [bot1, bot2, bot3, bot4] - [bot3]
puts bot_arr.include?(bot3)

# puts bot.orientation
# bot.turn_left!
# puts bot.orientation
# bot.turn_left!
# puts bot.orientation
# bot.turn_left!
# puts bot.orientation
# bot.turn_left!
# puts bot.orientation
# puts "oooo"
# bot.turn_right!
# puts bot.orientation
# bot.turn_right!
# puts bot.orientation
# bot.turn_right!
# puts bot.orientation
# bot.turn_right!
# puts bot.orientation
# bot.turn_right!
# puts bot.orientation
# bot.turn_right!
# puts bot.orientation