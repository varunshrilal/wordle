require "json"
require "open-uri"

# --- Word Bank ---
url = "https://darkermango.github.io/5-Letter-words/words.json"
response = URI.parse(url).read
WORDLE_BANK = JSON.parse(response)["words"].map(&:upcase)

# -- Game Setup --
secret_word = WORDLE_BANK.sample
secret_chars = secret_word.chars
MAX_GUESSES = 6
attempts_left = MAX_GUESSES
board = []
incorrect_letters = []

puts "--- Welcome to Wordle ---"

# --- Main Game Loop ---
loop do
  puts
  puts "#{attempts_left} attempts remaining."
  puts "Enter your guess (5 letters): "
  puts secret_word

  guess = gets.chomp.upcase
  guess_chars = guess.chars

  if guess.length != 5
    puts "❌ That’s not 5 letters. Try again!"
    next
  elsif !WORDLE_BANK.include?(guess)
    puts "🚫 Word not in the list. Try again!"
    next
  else
    attempts_left -= 1
  end

  # --- Feedback Logic ---
  feedback_display = Array.new(5)
  secret_pool = secret_chars.dup

  # --- Check for Greens ---
  guess.chars.each_with_index do |letter, i|
    if letter == secret_chars[i]
      feedback_display[i] = " 🟢 #{letter} "
      secret_pool[i] = nil
      incorrect_letters.delete(letter)
    end
  end

  # --- Check for Yellows & Grays ---
  guess.chars.each_with_index do |letter, i|
    next if feedback_display[i]
    if secret_pool.include?(letter)
      feedback_display[i] = " 🟡 #{letter} "
      secret_pool[secret_pool.index(letter)] = nil
      incorrect_letters.delete(letter)
    else
      feedback_display[i] = " ⬜ #{letter} "
      incorrect_letters << letter unless incorrect_letters.include?(letter)
    end
  end

  board << feedback_display.join

  # --- Display Board ---
  system("clear")
  puts "----------- WORDLE -----------"
  board.each { |row| puts row }
  puts "------------------------------"

  unless incorrect_letters.empty?
    puts "Used letters: #{incorrect_letters.uniq.sort.join(' ')}"
  end

  # --- Win/Loss Check ---
  if guess == secret_word
    puts "🎉 You guessed it in #{MAX_GUESSES - attempts_left} attempts! The word was #{secret_word}."
    break
  elsif attempts_left == 0
    puts "😢 Out of guesses! The correct word was #{secret_word}."
    break
  end
end
