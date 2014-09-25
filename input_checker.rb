class InputChecker
  def initialize(mastermind)
    @mastermind = mastermind
  end

  def check_guess
    case
    when @mastermind.quit?
      @mastermind.printer.goodbye
    when matches_colors?
      check_guess_length
    else
      @mastermind.printer.invalid_input
    end
  end

  def check_guess_length
    case
    when guess_too_short?
      @mastermind.printer.command_too_short
    when guess_too_long?
      @mastermind.printer.command_too_long
    else
      guess
    end
  end

  def guess_too_long?
    @mastermind.difficulty.code_length < @mastermind.command.length
  end

  def guess_too_short?
    @mastermind.difficulty.code_length > @mastermind.command.length
  end

  def valid_guess?
    @mastermind.difficulty.code_length == @mastermind.command.length &&
    matches_colors?
  end

  def matches_colors?
    regex = Regexp.new("[#{@mastermind.difficulty.colors_first_letters}]{4}")
    @mastermind.command =~ regex
  end

  def guess
    @mastermind.game.guess
    if @mastermind.game.correct?(@mastermind.command)
      @mastermind.printer.win(@mastermind.game)
    else
      @mastermind.printer.results(
      @mastermind.command, @mastermind.game.score(@mastermind.command))
    end
  end

  def check_difficulty
    case
    when @mastermind.quit?
      @mastermind.printer.goodbye
    when valid_difficulty?
      select_difficulty
    else
      @mastermind.printer.invalid_input
    end
  end

  def valid_difficulty?
    "bia".chars.any? { |char| char == @mastermind.command}
  end

  def select_difficulty
    case @mastermind.command
    when "b"
      @mastermind.difficulty = Difficulty.beginner
    when "i"
      @mastermind.difficulty = Difficulty.intermediate
    when "a"
      @mastermind.difficulty = Difficulty.advanced
    end
  end
end
