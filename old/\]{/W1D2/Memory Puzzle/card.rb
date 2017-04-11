class Card
  attr_reader :value,:visible

  def initialize(value)
    @value = value
    @visible = false
  end

  def hide
    @visible = false
  end

  def reveal
    @visible = true
  end

  def to_s
    @value
  end

  def ==(value)
    @value == value
  end
end
