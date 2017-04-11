require_relative 'card.rb'
require_relative 'board.rb'

class Game

  def initialize(n = 4)
    @board = Board.new(n)
    @guessed_pos = nil
    @previous_guess = nil
  end

  def make_guess
    # puts "What row?"
    # row = gets.chomp.to
    puts "Make your guess."
    @previous_guess = @guessed_pos
    @guessed_pos = gets.chomp.split(",").map(&:to_i)
  end

  def generate_cards
    cards = []
    (@board.board.flatten.length / 2).times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end

    cards
  end

  def play
    @board.populate(generate_cards)
    @board.render
    until @board.won?
      @board.reveal(make_guess)
      @board.reveal(make_guess)
      @board.render
      unless @board[@guessed_pos] == @board[@previous_guess]
        sleep(5)
        @board[@guessed_pos].hide
        @board[@previous_guess].hide
        @board.render
      end
    end

    puts "Congrats! You won!!!"
  end

end

if __FILE__ == $PROGRAM_NAME
  begin
    puts "What length of board would you like?"
    n = gets.chomp.to_i
  rescue (n * n).odd?
    puts "Not even"
  end
  Game.new(n).play
end
