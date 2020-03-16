class RadarRenderer
  def initialize(radar_signal)
    @radar_signal = Marshal.load(Marshal.dump(radar_signal))
  end

  def render(invader_results)
    invader_results.each do |invader, results|
      results.each do |i, j|
        colorize_alien_on_radar(invader, invader.color, i, j)
      end
    end

    view
  end

  def view
    @radar_signal.map { |row| row.join('') }.join("\n")
  end

  private

    def colorize_alien_on_radar(invader, color, row_index, column_index)
      row_start_index = (invader.height - row_index) < 0 ?
                          0 : invader.height - row_index

      row_end_index = invader.height
      (row_start_index..row_end_index).each do |i|
        column_start_index = (invader.width - column_index) < 0 ?
                               0 : invader.width - column_index

        column_end_index = invader.width

        (column_start_index..column_end_index).each do |j|
          check_row_index = row_index - (row_end_index - i)
          check_column_index = column_index - (column_end_index - j)

          char = @radar_signal.dig(check_row_index, check_column_index)
          unless char.nil?
            @radar_signal[check_row_index][check_column_index] =
              "\e[#{color}m#{char}\e[0m" if ["-", "o"].include?(char)
          end
        end
      end
    end
end
