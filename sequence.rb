class Sequence
  attr_reader :code

  def initialize(difficulty)
    @code = (1..difficulty.code_length).collect do
      difficulty.colors[rand(difficulty.colors.length)][0]
    end.join.downcase
  end

  def equals?(guess)
    code == guess.downcase
  end

  def check_against(guess)
    guess.downcase!
    correct_elements = guess.chars.uniq.count { |char| code.include?(char) }

    correct_positions = guess.chars.zip(code.chars)
    .count { |pair| pair.reduce(:==) }

    [correct_elements, correct_positions]
  end

  def to_s
    code.upcase
  end
end
