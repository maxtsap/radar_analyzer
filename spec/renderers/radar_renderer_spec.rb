require_relative '../../renderers/radar_renderer'
require_relative '../../models/invader'

RSpec.describe RadarRenderer do
  let(:radar_signal) { [%w(- o), %w(o -)] }
  let(:invader) { Invader.new({form: [%w(- o)], color: 31}) }
  let(:radar_renderer) { RadarRenderer.new(radar_signal) }

  it "renders matches" do
    radar_renderer.render({invader => [[0, 1]]})
    expect(radar_renderer.view).to eq("\e[31m-\e[0m\e[31mo\e[0m\no-")
  end
end
