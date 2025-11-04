# Wordle - A Command-Line Ruby Clone

This is a simple, command-line implementation of the popular word game Wordle, written in pure Ruby.

It pulls a real-world, 5-letter word list from an open-source JSON file, so all guesses are validated against a dictionary.

## Demo

Here is an example of the game in action:

----------- WORDLE ----------- 

🟡 L ⬜ O 🟡 S 🟡 E ⬜ R 

🟢 L 🟢 O ⬜ O 🟢 S 🟡 E 

🟢 L 🟢 O 🟡 S 🟡 E 🟢 S 

🟢 L 🟢 O 🟢 E 🟢 S 🟢 S

Used letters: R O 🎉 You guessed it! The word was LOESS.

Play again? (Y/N)

## Features

* **Full Game Logic:** Correctly identifies 🟢 (green), 🟡 (yellow), and ⬜ (gray) letters.
* **Intelligent Feedback:** Correctly handles double letters (e.g., if the word is `ALLOW` and you guess `LLAMA`).
* **Used Letter Tracking:** Displays all incorrect letters at the bottom of the screen to help you guess.
* **Word Validation:** Checks your guess against a 5,000+ word dictionary.
* **"Play Again" Loop:** Lets you play multiple rounds.

## How to Run

This is a command-line game and requires Ruby to be installed on your system.

1.  **Prerequisite:** Make sure you have [Ruby installed](https://www.ruby-lang.org/en/downloads/).

2.  **Clone the Repository:**
    ```bash
    git clone https://github.com/varunshrilal/wordle.git
    ```

3.  **Navigate to the Folder:**
    ```bash
    cd wordle
    ```

4.  **Run the Game:**
    ```bash
    ruby main.rb
    ```
    No external gems are needed!

## File Structure

The project is split into two files for better organization:

* **`game.rb`**: This file contains the `WordleGame` class, which holds all the game logic, state, and feedback processing.
* **`main.rb`**: This is the executable file. It loads the `WordleGame` class and runs the "Play Again?" loop.
