module Services
  class DetectInvaderPosition
    def initialize(radar, invader, v_index, h_index)
      @radar = radar
      @invader = invader
      @v_index = v_index
      @h_index = h_index
      @actual_matches = 0
      @expected_matches = 0
    end

    def call
      @invader.each_start_from(
        invader_row_start_index, invader_column_start_index
      ) do |char, delta_v_index, delta_h_index|

        check_row_index = @v_index - delta_v_index
        check_column_index = @h_index - delta_h_index

        radar_char = @radar.get(check_row_index, check_column_index)

        unless radar_char.nil?
          @expected_matches += 1

          @actual_matches += 1 if radar_char == char
        end
      end

      @expected_matches > 0 && enough_entries? ? matching_percentage : 0
    end

    private

      def invader_row_start_index
        @invader.height - @v_index < 0 ? 0 : @invader.height - @v_index
      end

      def invader_column_start_index
        @invader.width - @h_index < 0 ? 0 : @invader.width - @h_index
      end

      def enough_entries?
        @actual_matches > @invader.size / 4
      end

      def matching_percentage
        100 / @expected_matches * @actual_matches
      end
  end
end
