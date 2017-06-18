class Codemaker

  attr_reader :code

  def initialize(colors, choice)
    @code = Array.new
    @colors = colors
    @choice = choice
  end

  def generate_code
    if @choice
      (0..3).each do |i|
        @code[i] = gets.chomp.to_i
      end
    else
      @code = @colors.sample(4)
    end
  end

  def generate_feedback_code(code_guess)
    a = code_guess.clone
    b = code.clone

    feedback = Array.new
    comparisons = Array.new

    a.zip(b).map { |i, j| comparisons << (i == j)  }

    (0..3).each do |i|
      if comparisons[i] == true
        feedback << 2
        b[i] = -1
      end
    end
    (0..3).each do |i|
      if comparisons[i] == false
        if b.include?a[i]
          feedback << 1
        else
          feedback << 0
        end
      end
    end

      feedback.sort.reverse
    end

end
