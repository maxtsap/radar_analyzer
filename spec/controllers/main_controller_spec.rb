require_relative '../../controllers/main_controller'
require_relative '../../models/radar_signal'
require_relative '../../services/get_most_probable_positions'

RSpec.describe MainController do
  let(:signal) { "-o\no-" }
  let(:radar_signal) { [%w(- o), %w(o -)] }
  let(:radar) { double(signal: radar_signal) }
  let(:renderer) { double(render: nil, view: 'view results') }
  let(:analyzer) { double(call: {[0, 0] => 0}) }
  let(:invader)  { Invader.add({form: [], color: 1}) }
  let(:controller) { described_class.new }
  let(:show_matches) { controller.show_matches(signal) }

  def stub_radar_signal
    allow(RadarSignal).to(
      receive(:new).and_return(radar)
    )
  end

  def stub_radar_renderer
    allow(RadarRenderer).to(
      receive(:new).and_return(renderer)
    )
  end

  def stub_radar_get_most_probable_positions
    allow(Services::GetMostProbablePositions).to(
      receive(:new).and_return(analyzer)
    )
  end

  it "creates RadarSignal" do
    expect(RadarSignal).to(
      receive(:new).with(radar_signal).and_return(radar)
    )

    show_matches
  end

  it "creates ResultsRenderer" do
    expect(RadarRenderer).to(
      receive(:new).with(radar_signal).and_return(renderer)
    )

    show_matches
  end

  it "creates RadarAnalyzer" do
    stub_radar_signal
    stub_radar_renderer

    expect(Services::GetMostProbablePositions).to(
      receive(:new).with(radar, invader).and_return(analyzer)
    )

    show_matches
  end

  it "calls ResultsRenderer#render" do
    stub_radar_get_most_probable_positions
    stub_radar_renderer

    expect(renderer).to(
      receive(:render).with({invader => analyzer.call})
    )

    show_matches
  end

  it "returns results of ResultsRenderer" do
    stub_radar_get_most_probable_positions

    expect(RadarSignal).to(
      receive(:new).with(radar_signal).and_return(radar)
    )

    expect(RadarRenderer).to(
      receive(:new).with(radar_signal).and_return(renderer)
    )

    expect(show_matches).to eq('view results')
  end
end
