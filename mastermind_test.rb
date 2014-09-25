gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require "stringio"
require_relative "mastermind"

class MastermindTest < Minitest::Test
  def test_quit
    tester = StringIO.new("quit")
    game = Mastermind.new(StringIO.new, tester)
    refute game.quit?

    game.gets_command
    assert game.quit?

    tester.string = "q"
    game.gets_command
    assert game.quit?
  end

  def test_play
    tester = StringIO.new("play")
    game = Mastermind.new(StringIO.new, tester)
    refute game.play?

    game.gets_command
    assert game.play?

    tester.string = "p"
    game.gets_command
    assert game.play?
  end

  def test_instructions
    tester = StringIO.new("instructions")
    game = Mastermind.new(StringIO.new, tester)
    refute game.instructions?

    game.gets_command
    assert game.instructions?

    tester.string = "i"
    game.gets_command
    assert game.instructions?
  end

  def test_play_game_beginner
    tester = StringIO.new("b\nrgby\nrgby\nrgby\nq\n")
    game = Mastermind.new(StringIO.new, tester)
    game.play_game
    assert_equal 3, game.game.guesses
  end

  def test_play_game_intermediate
    tester = StringIO.new("i\nrgbyor\nrgbyor\nrgbyor\nq\n")
    game = Mastermind.new(StringIO.new, tester)
    game.play_game

    assert_equal 3, game.game.guesses
  end

  def test_play_game_advanced
    tester = StringIO.new("a\nrgbyoprg\nrgbyoprg\nrgbyoprg\nq\n")
    game = Mastermind.new(StringIO.new, tester)
    game.play_game

    assert_equal 3, game.game.guesses
  end

  def test_game_over
    tester = StringIO.new("b")
    game = Mastermind.new(StringIO.new, tester)
    refute game.game_over?
    game.request_difficulty
    assert game.game_over?
  end
end
