require_relative 'board.rb'

class Game

  def initialize(board)
    @board = board
  end

  def play

    until @board.solved?
      @board.render
      pos = @board.get_pos
      val = @board.get_val
      @board.update_board(pos, val)
    end

  end

end

b = Board.from_file('sudoku1.txt')
game = Game.new(b)
game.play
