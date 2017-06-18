require_relative 'game.rb'

colors_array = [1, 2, 3, 4, 5, 6]

puts "Maker or Breaker?(M/B)"
input = gets.chomp.upcase!

case input
when 'M'
  game = Game.new(colors_array, true)
  game.start_game
when 'B'
  game = Game.new(colors_array, false)
  game.start_game
else
  puts "Invalid Input"
end
