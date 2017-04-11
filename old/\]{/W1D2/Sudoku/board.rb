require 'byebug'
require 'colorize'
require 'colorized_string'
require_relative 'tile.rb'

class Board
  attr_reader :file, :grid, :box1

  def initialize(file)
    @file = set_file(file)
    @grid = Array.new(9) {Array.new(9, nil) }
    setup_grid(@file)
  end

  def self.from_file(file)
    Board.new(file)
  end

  def setup_grid(file)
    file.each_with_index do |row, i|
      row.each_with_index do |el, j|
        @grid[i][j] = Tile.new(el)
      end
    end
  end

  def set_file(file)
    rows = File.readlines(file).map(&:chomp)
    rows.map! { |row| row.split("").map(&:to_i) }
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def render
    system("clear")
    @grid.each do |row|
      row.each do |tile|
        if tile.given
          print " #{tile.value.to_s.colorize(:red)}"
        elsif tile.value == 0
          print " X"
        else
          print " #{tile.value.to_s.colorize(:black)}"

          #print tile.given ? " #{tile.value.to_s.colorize(:red)}" : " X"
        end
      end
      print "\n"
    end
  end

  def tile_values(arr)
    values = []
    arr.each do |tile|
      values << tile.value
    end
    values
  end

  def check_box
    box1 = grid[0][0..2] + grid[1][0..2] + grid[2][0..2]
    box2 = grid[0][3..5] + grid[1][3..5] + grid[2][3..5]
    box3 = grid[0][6..8] + grid[1][6..8] + grid[2][6..8]

    box4 = grid[3][0..2] + grid[4][0..2] + grid[5][0..2]
    box5 = grid[3][3..5] + grid[4][3..5] + grid[5][3..5]
    box6 = grid[3][6..8] + grid[4][6..8] + grid[5][6..8]

    box7 = grid[6][0..2] + grid[7][0..2] + grid[8][0..2]
    box8 = grid[6][3..5] + grid[7][3..5] + grid[8][3..5]
    box9 = grid[6][6..8] + grid[7][6..8] + grid[8][6..8]

    boxes = [box1, box2, box3, box4, box5, box6, box7, box8, box9]

    boxes.each do |box|
      (1..9).each do |i|
        return false unless tile_values(box).include?(i)
      end
    end
    true
  end

  def check_rows
    grid.each do |row|
      (1..9).each do |i|
        return false unless tile_values(row).include?(i)
      end
    end
    true
  end

  def check_colums
    grid.transpose.each do |row|
      (1..9).each do |i|
        return false unless tile_values(row).include?(i)
      end
    end
    true
  end

  def solved?
    check_box && check_rows && check_colums
  end

  def get_pos
    puts "What postion would you like to change?"
    pos = gets.chomp.split(",").map(&:to_i)

    until valid_pos(pos)
      puts "Invalid position. Try again"
      pos = gets.chomp.split(",").map(&:to_i)
    end

    pos
  end

  def valid_pos(pos)
    !self[pos].given
  end

  def get_val
    puts "What value would you like to guess?"
    val = gets.chomp.to_i

    until valid_val(val)
      puts "Invalid value. Try Again."
      val = gets.chomp.to_i
    end

    val
  end

  def valid_val(val)
    (1..9).to_a.include?(val)
  end

  def update_board(pos, val)
    self[pos].value = val
  end



end

# game = Board.from_file('sudoku1-solved.txt')
# game.render
# box1 = game.grid[0][0..2] + game.grid[1][0..2] + game.grid[2][0..2]
# #p box1
# p game.solved?
