require_relative "sequence"
require_relative "difficulty"
require "time"

class Game
  attr_reader :secret_code, :guesses

  def initialize(difficulty = Difficulty.beginner)
    @secret_code = Sequence.new(difficulty)
    @start_time = Time.now
    @guesses = 0
  end

  def seconds_since_start
    (Time.now - @start_time).to_i
  end

  def correct?(guess)
    secret_code.equals?(guess)
  end

  def score(code)
    secret_code.check_against(code)
  end

  def guess
    @guesses += 1
  end
end
