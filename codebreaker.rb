class Codebreaker

  attr_accessor :code

  def initialize(colors, choice)
    @code = Array.new(4)
    @colors = colors
    @choice = choice
    @set = (1111..6666).to_a
  end

  def modify_set
    @set.each do |i|
      j = i.to_s.split('')
      j.each do |k|
        if k.to_i < 1 ||  k.to_i > 6
          @set.delete(i)
          break
        end
      end
    end
  end

  def get_code(fb)
    unless @choice
      (0..3).each do |i|
        @code[i] = gets.chomp.to_i
      end
    else
      find_solution(fb)
    end
  end

  def find_solution(fb)
    if fb.all? { |i| i == nil }
      @code = @set[0].to_s.each_char.map(&:to_i)
    else
      #AI
      modify_set
      @set.each do |i|
        if fb != feedback_generator(i.to_s.each_char.map(&:to_i), @code)
          @set.delete(i)
        end
      end
    end
  end

  def feedback_generator(code_set, code_guess)
    a = code_set.clone
    b = code_guess.clone

    feedback = Array.new
    comparisons = Array.new

    a.zip(b).map { |i, j| comparisons << (i == j) }

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
