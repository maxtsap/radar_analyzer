require_relative 'detect_invader_position'

module Services
  class DetectAllInvaderPositions
    def initialize(radar, invader)
      @radar = radar
      @invader = invader
      @results = {}
    end

    def call
      extended_radar_rows.each do |i|
        extended_radar_columns.each do |j|
          @results[[i, j]] = DetectInvaderPosition.new(@radar, @invader, i, j).call
        end
      end

      @results
    end

    private

      def extended_radar_rows
        0..(@radar.height + @invader.height)
      end

      def extended_radar_columns
        0..(@radar.width + @invader.width)
      end
  end
end
