require 'byebug'
class Board
  attr_reader :board

  def initialize(n)
    @board = Array.new(n) { Array.new(n) }
  end

  def populate(cards)
    cards = cards.shuffle
    board.each_with_index do |row, i|
      row.each_index do |j|
        board[i][j] = cards.pop
      end
    end
  end

  def render
    #will need to show card value once revealed
    system("clear")
    board.each do |row|
      row.each do |card|
        print card.visible ? card.value : "X"
      end
      print "\n"
    end
  end

  def won?
    board.flatten.each do |card|
      return false unless card.visible
    end
    true
  end



  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos, val)
    x, y = pos
    board[x][y] = val
  end

  def reveal(guessed_pos)
    #debugger
    unless board[guessed_pos[0]][guessed_pos[1]].visible
      board[guessed_pos[0]][guessed_pos[1]].reveal
    end
  end

end
