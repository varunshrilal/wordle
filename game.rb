require "json"
require "open-uri"

# --- Constants ---
#
url = "https://darkermango.github.io/5-Letter-words/words.json"
response = URI.parse(url).read
WORDLE_BANK = JSON.parse(response)["words"].map(&:upcase)
MAX_GUESSES = 6

# --- Class ---
#
class WordleGame
  def initialize
    @secret_word = WORDLE_BANK.sample
    @secret_chars = @secret_word.chars
    @attempts_left = MAX_GUESSES
    @board = []
    @incorrect_letters = []
  end

  def play
    puts "--- Welcome to Wordle ---"

    loop do
      #--- Get Guess ---
      display_status
      guess = get_valid_guess

      #--- Process Guess ---
      process_feedback(guess)
      display_board

      # --- Win/Loss Check ---
      if guess == @secret_word
        puts "🎉 You guessed it! The word was #{@secret_word}."
        break
      elsif @attempts_left == 0
        puts "😢 Out of guesses! The correct word was #{@secret_word}."
        break
      end
    end
  end

  # --- Private Methods ---
  private

  def display_status
    puts
    puts "#{@attempts_left} attempts remaining."
    puts "Enter your guess (5 letters): "
  end

  def get_valid_guess
    loop do
      guess = gets.chomp.upcase

      if guess.length != 5
        puts "❌ That’s not 5 letters. Try again!"
      elsif !WORDLE_BANK.include?(guess)
        puts "🚫 Word not in the list. Try again!"
      else
        @attempts_left -= 1
        return guess
      end
    end
  end

  def process_feedback(guess)
    feedback_display = Array.new(5)
    secret_pool = @secret_chars.dup
    guess_chars = guess.chars

    # --- Check for Greens ---
    guess_chars.each_with_index do |letter, i|
      if letter == @secret_chars[i]
        feedback_display[i] = " 🟢 #{letter} "
        secret_pool[i] = nil
        @incorrect_letters.delete(letter)
      end
    end

    # --- Check for Yellows & Grays ---
    guess_chars.each_with_index do |letter, i|
      next if feedback_display[i]
      if secret_pool.include?(letter)
        feedback_display[i] = " 🟡 #{letter} "
        secret_pool[secret_pool.index(letter)] = nil
        @incorrect_letters.delete(letter)
      else
        feedback_display[i] = " ⬜ #{letter} "
        @incorrect_letters << letter unless @incorrect_letters.include?(letter)
      end
    end
    @board << feedback_display.join
  end

  def display_board
    system("clear") || system("cls")
    puts "----------- WORDLE -----------"
    @board.each { |row| puts row }
    puts "------------------------------"

    unless @incorrect_letters.empty?
      puts "Used letters: #{@incorrect_letters.uniq.sort.join(' ')}"
    end
  end
end
