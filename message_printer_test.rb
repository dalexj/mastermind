gem "minitest", "~> 5.2"
require "minitest/autorun"
require "minitest/pride"
require "stringio"
require_relative "message_printer"

class String
  def colorize(code)
    self
  end
end

class MessagePrinterTest < Minitest::Test
  def test_give_space
    tester = StringIO.new
    printer = MessagePrinter.new(tester)
    printer.give_space
    assert_equal "\n\n\n\n", tester.string
  end

  def test_welcome
    tester = StringIO.new
    printer = MessagePrinter.new(tester)
    printer.welcome
    assert_equal "Welcome to MASTERMIND, SUCKER\n", tester.string
  end

  def test_initial_request
    tester = StringIO.new
    printer = MessagePrinter.new(tester)
    printer.initial_request
    assert_equal "Would you like to (p)lay, read the (i)nstructions, \
or (q)uit?\n", tester.string
  end

  def test_goodbye
    tester = StringIO.new
    printer = MessagePrinter.new(tester)
    printer.goodbye
    assert_equal "Cya sucker!\n", tester.string
  end

  def test_instructions
    tester = StringIO.new
    printer = MessagePrinter.new(tester)
    printer.instructions
    assert_equal "I the computer, make a sequence of 4-8 colors, you must guess \
which colors they are and in what position they are in. git r3ddy 4 madnes u nub\n", tester.string
  end
end
