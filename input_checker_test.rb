gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require "stringio"
require_relative "input_checker"
require_relative "mastermind"

class MastermindTest < Minitest::Test
  def test_guess_lengths
    tester = StringIO.new("rrrr\nrrr\nrrrrr")
    game = Mastermind.new(StringIO.new, tester)
    input_checker = InputChecker.new(game)
    game.gets_command
    refute input_checker.guess_too_long?
    refute input_checker.guess_too_short?

    game.gets_command
    refute input_checker.guess_too_long?
    assert input_checker.guess_too_short?

    game.gets_command
    assert input_checker.guess_too_long?
    refute input_checker.guess_too_short?
  end

  def test_matches_colors
    tester = StringIO.new("rgby\nrgba\nrgab\nragb\nargb")
    game = Mastermind.new(StringIO.new, tester)
    input_checker = InputChecker.new(game)
    game.gets_command
    assert input_checker.matches_colors?
    4.times do
      game.gets_command
      refute input_checker.matches_colors?
    end
  end

  def test_valid_guess
    tester = StringIO.new("rgby\nrgbq\nqrgb\nrrgby\nrgb")
    game = Mastermind.new(StringIO.new, tester)
    input_checker = InputChecker.new(game)
    game.gets_command
    assert input_checker.valid_guess?
    4.times do
      game.gets_command
      refute input_checker.valid_guess?
    end
  end

  def test_valid_difficulty
    tester = StringIO.new("b\ni\na\nq\nbia\nbi")
    game = Mastermind.new(StringIO.new, tester)
    input_checker = InputChecker.new(game)
    3.times do
      game.gets_command
      assert input_checker.valid_difficulty?
    end

    3.times do
      game.gets_command
      refute input_checker.valid_difficulty?
    end
  end

end
