require_relative "game"
require_relative "input_checker"
require_relative "color"
require_relative "message_printer"
require_relative "difficulty"

class Mastermind
  attr_reader :command, :game, :printer, :input_checker
  attr_accessor :difficulty

  def initialize(stdout = $stdout, stdin = $stdin)
    @command = ""
    @printer = MessagePrinter.new(stdout)
    @stdin = stdin
    @difficulty = Difficulty.beginner
    @input_checker = InputChecker.new(self)
  end

  def start
    printer.give_space
    printer.welcome
    until quit?
      game_over? ? printer.play_again_request : printer.initial_request
      gets_command
      process_first_commands
    end
  end

  def gets_command
    @command = @stdin.gets.strip.downcase
  end

  def quit?
    command == "q" || command == "quit"
  end

  private

  def process_first_commands
    case
    when quit?
      printer.goodbye
    when instructions?
      printer.instructions
    when play?
      play_game
    else
      printer.invalid_input
    end
  end

  def play?
    command == "p" || command == "play"
  end

  def instructions?
    command == "i" || command == "instructions"
  end

  def play_game
    request_difficulty
    printer.game_start(difficulty) unless quit?
    until quit? || game.correct?(command)
      request_guess
      # puts "#{game.secret_code}"
    end
  end

  def request_difficulty
    until quit? || input_checker.valid_difficulty?
      printer.difficulty_request
      gets_command
      input_checker.check_difficulty
    end
    @game = Game.new(difficulty)
  end

  def request_guess
    @command = ""
    until quit? || input_checker.valid_guess?
      printer.guess_request
      gets_command
      input_checker.check_guess
    end
  end

  def game_over?
    game
  end
end

Mastermind.new.start
