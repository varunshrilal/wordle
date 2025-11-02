
require_relative "game"

loop do
  game = WordleGame.new
  game.play

  puts
  puts "Play again? (Y/N)"
  play_again = gets.chomp.upcase

  break if play_again != "Y"
end

puts "Thanks for playing!"
