require_relative 'codemaker.rb'
require_relative 'codebreaker.rb'

class Game

  def initialize(colors, choice)
    @cm = Codemaker.new(colors, choice)
    @cb = Codebreaker.new(colors, choice)
    @board = Array.new(12, '_') { Array.new(8, '_') }
  end

  def start_game
    puts "Welcome to Mastermind!\nThe left side represents entered codes, right represents respective feedback\nGo!"
    @cm.generate_code
    fb_code = Array.new
    draw_board(fb_code)

    (0..11).each do |i|
      @cb.get_code(fb_code)
      fb_code = @cm.generate_feedback_code(@cb.code).clone
      modify_board(i, fb_code)
      draw_board(fb_code)
      if fb_code.all? { |i| i == 2 }
        break
      end
    end

    if @cm.code != @cb.code
      puts "You lost.\n Correct Answer : "+@cm.code.to_s
    else
      puts "You Won!"
    end
  end

  def draw_board(fb_code)
    puts "\t   "+"CODE"+("\t"*5)+"FEEDBACK"
    (0..11).each do |i|
      (0..3).each do |j|
        print @board[i][j].to_s+"\t"
      end
      print "\t"
      (4..7).each do |j|
        print @board[i][j].to_s+"\t"
      end
      puts ""
    end
  end

  def modify_board(i, fb_code)
    (0..3).each do |j|
      @board[-i-1][j] = @cb.code[j]
    end
    (4..7).each do |j|
      @board[-i-1][j] = fb_code[j-4]
    end
  end

end
