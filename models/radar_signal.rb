class RadarSignal
  attr_reader :signal

  def initialize(signal)
    @signal = signal
  end

  def height
    @signal.size - 1
  end

  def width
    @signal.first.size - 1
  end

  def get(v_index, h_index)
    @signal.dig(v_index, h_index)
  end
end

