gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative "game"

class GameTest < Minitest::Test
  def test_initialize
    game = Game.new(Difficulty.beginner)

    assert_equal 0, game.guesses
    assert_match /[rgby]{4}/, game.secret_code.code
  end

  def test_timer
    game = Game.new(Difficulty.beginner)
    time = sleep(rand(3))
    assert_equal time, game.seconds_since_start
  end

  def test_correct
    game = Game.new(Difficulty.beginner)

    code = game.secret_code.code
    assert game.correct?(code)
    refute game.correct?("abcd")
  end

  def test_guess
    game = Game.new(Difficulty.beginner)
    assert_equal 0, game.guesses
    99.times { game.guess }
    assert_equal 99, game.guesses
  end

end
