class Difficulty
  attr_reader :code_length, :colors, :name

  def initialize(code_length, colors, name)
    @name = name
    @code_length = code_length
    @colors = colors
  end

  def colors_first_letters
    colors.collect { |color| color[0] }.join
  end

  def self.beginner
    new(4, %w(red green blue yellow), "beginner")
  end

  def self.intermediate
    new(6, %w(red green blue yellow orange), "intermediate")
  end

  def self.advanced
    new(8, %w(red green blue yellow orange pink), "advanced")
  end
end
