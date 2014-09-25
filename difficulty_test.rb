gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative "difficulty"

class DifficultyTest < Minitest::Test
  def test_initialize
    difficulty_one = Difficulty.new(1, %w(red green), "test")
    difficulty_two = Difficulty.new(6, %w(abc blue), "other_name")

    assert_equal 1, difficulty_one.code_length
    assert_equal 6, difficulty_two.code_length
    assert_equal ["red", "green"], difficulty_one.colors
    assert_equal ["abc", "blue"], difficulty_two.colors
    assert_equal "test", difficulty_one.name
    assert_equal "other_name", difficulty_two.name
  end

  def test_colors_first_letters
    difficulty_one = Difficulty.new(1, %w(red green), "")
    difficulty_two = Difficulty.new(1, %w(orange blue), "")

    assert_equal "rg", difficulty_one.colors_first_letters
    assert_equal "ob", difficulty_two.colors_first_letters
  end
end
