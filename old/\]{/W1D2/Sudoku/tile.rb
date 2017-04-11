class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value)
    @value = value
    @given = value != 0
    @color = @given ? :red : :black
  end

end
