require_relative '../../services/detect_all_invader_positions'
require_relative '../../models/radar_signal'
require_relative '../../models/invader'

RSpec.describe Services::DetectAllInvaderPositions do
  let(:radar) { RadarSignal.new([%w(- o), %w(o -)]) }
  let(:invader) { Invader.new({form: [%w(- o)], color: 1}) }
  let(:service) { described_class.new(radar, invader) }

  it "calls Services::DetectInvaderPosition" do
    expect(Services::DetectInvaderPosition).to(
      receive(:new).exactly(6).times.and_call_original
    )

    service.call
  end

  it "returns results of Services::DetectInvaderPosition" do
    allow_any_instance_of(Services::DetectInvaderPosition).to(
      receive(:call).and_return(50)
    )

    expect(service.call).to(eq(
      {[0, 0]=>50, [0, 1]=>50, [0, 2]=>50, [1, 0]=>50, [1, 1]=>50, [1, 2]=>50})
    )
  end

  it "returns results" do
    expect(service.call).to(
      eq({[0, 0]=>0, [0, 1]=>100, [0, 2]=>0, [1, 0]=>100, [1, 1]=>0, [1, 2]=>0})
    )
  end
end
