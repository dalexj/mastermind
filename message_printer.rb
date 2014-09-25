require_relative "color"

class MessagePrinter
  attr_reader :stream

  def initialize(stdout)
    @stream = stdout
  end

  def give_space
    stream.puts "\n\n\n\n"
  end

  def welcome
    stream.puts "Welcome to MASTERMIND, SUCKER".colorize(Color::BLUE_BACKGROUND)
  end

  def initial_request
    stream.puts "Would you like to (p)lay, read the (i)nstructions, \
or (q)uit?".colorize(Color::GREEN_TEXT)
  end

  def goodbye
    stream.puts "Cya sucker!"
  end

  def instructions
    stream.print "I the computer, make a sequence of 4-8 colors, you must guess \
which colors they are and in what position they are in. "
    stream.puts "git r3ddy 4 madnes u nub".colorize(Color::RED_TEXT)
  end

  def game_start(difficulty)
    match_last_word = / \W\w\W\w*$/
    colors_with_parens = difficulty.colors.collect do |color|
      "(#{color[0]})#{color[1..-1]}"
    end
    colors_in_message = colors_with_parens.join(", ")
    colors_in_message.sub!(match_last_word, " and #{colors_with_parens.last}")

    stream.puts "I have generated a #{difficulty.name} sequence with \
#{number_to_word(difficulty.code_length)} elements made up of: \
#{colors_in_message}. Use (q)uit at any time to end the \
game.".colorize(Color::CYAN_TEXT)
  end

  def win(game)
    minutes, seconds = game.seconds_since_start.divmod(60)
    stream.puts "Congratulations! You guessed the sequence \
'#{game.secret_code}' in #{game.guesses} guesses over #{minutes} minutes, \
#{seconds} seconds... but that one was an easy one anyway. You should try \
something harder, nub".colorize(Color::BLUE_BACKGROUND)
  end

  def results(guess_code, results)
    stream.puts "'#{guess_code}' has #{results[0]} of the correct elements \
with #{results[1]} in the correct positions".colorize(Color::GREEN_TEXT)
  end

  def invalid_input
    stream.puts "Get gud plz u nub".colorize(Color::RED_TEXT)
  end

  def guess_request(guess_type = "next")
    stream.puts "What's your #{guess_type} guess, scrub?".colorize(Color::MAGENTA_TEXT)
  end

  def difficulty_request
    stream.puts "Do you want to play a (b)eginner, (i)ntermediate, \
or (a)dvanced game?"
  end

  def play_again_request
    stream.puts "Do you want to (p)lay again or (q)uit?".colorize(Color::GREEN_TEXT)
  end

  def command_too_long
    stream.puts "Input too long".colorize(Color::RED_TEXT)
  end

  def command_too_short
    stream.puts "Input too short".colorize(Color::RED_TEXT)
  end

  private

  def number_to_word(number)
    case number
    when 4
      "four"
    when 6
      "six"
    when 8
      "eight"
    end
  end
end
