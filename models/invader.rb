class Invader
  @@all = []

  attr_reader :color

  def self.add(args)
    self.new(args)
  end

  def self.all
    @@all
  end

  def initialize(invader)
    @form = invader[:form]
    @color = invader[:color]
    @@all << self
  end

  def height
    @form.size - 1
  end

  def width
    @form.first&.size - 1
  end

  def get(v_index, h_index)
    @form.dig(v_index, h_index)
  end

  def size
    @form.flatten.count("o")
  end

  def each_start_from(v_index, h_index)
    (v_index..height).each do |i|
      (h_index..width).each do |j|
        char = @form.dig(i, j)
        yield(char, height - i, width - j) if char == "o"
      end
    end
  end
end
