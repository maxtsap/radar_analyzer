require_relative '../constants'
require_relative 'detect_all_invader_positions'

module Services
  class GetMostProbablePositions
    def initialize(radar, invader)
      @radar = radar
      @invader = invader
    end

    def call
      most_probable_positions_of.keys
    end

    private

      def most_probable_positions_of
        all_possible_positions_of.select { |_, percent| percent > THRESHOLD }
      end

      def all_possible_positions_of
        Services::DetectAllInvaderPositions.new(@radar, @invader).call
      end
  end
end
