require_relative '../renderers/radar_renderer'
require_relative '../services/get_most_probable_positions'
require_relative '../models/invader'
require_relative '../models/radar_signal'

class MainController
  def show_matches(signal)
    @radar = RadarSignal.new(signal.split("\n").map { |s| s.split('') })

    Invader.all.each do |invader|
      renderer.render(
        {
          invader => Services::GetMostProbablePositions.new(@radar, invader).call
        }
      )
    end

    renderer.view
  end

  private

    def renderer
      @renderer ||= RadarRenderer.new(@radar.signal)
    end
end
