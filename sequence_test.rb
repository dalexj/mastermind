gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require_relative "sequence"
require_relative "difficulty"

class SequenceTest < Minitest::Test
  def test_initialize
    sequence_one = Sequence.new(Difficulty.beginner, "abcd")
    sequence_two = Sequence.new(Difficulty.beginner, "dcba")

    assert_equal "abcd", sequence_one.code
    assert_equal "dcba", sequence_two.code
  end

  def test_equals
    sequence_one = Sequence.new(Difficulty.beginner, "abcd")
    sequence_two = Sequence.new(Difficulty.beginner, "dcba")

    assert sequence_one.equals?("abcd")
    assert sequence_two.equals?("dcba")

    refute sequence_one.equals?("aaaa")
    refute sequence_two.equals?("aaaa")
  end

  def test_check_against
    sequence = Sequence.new(Difficulty.beginner, "abcd")

    assert_equal [0, 0], sequence.check_against("zzzz")
    assert_equal [1, 1], sequence.check_against("aaaa")
    assert_equal [2, 2], sequence.check_against("abbb")
    assert_equal [3, 3], sequence.check_against("abcc")
    assert_equal [4, 4], sequence.check_against("abcd")
  end

  def test_to_s
    sequence_one = Sequence.new(Difficulty.beginner, "abcd")
    sequence_two = Sequence.new(Difficulty.beginner, "dcba")

    assert_equal "ABCD", sequence_one.to_s
    assert_equal "DCBA", sequence_two.to_s
  end

end
