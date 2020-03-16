require_relative '../../services/get_most_probable_positions'
require_relative '../../models/invader'

RSpec.describe Services::GetMostProbablePositions do
  let(:radar_signal) { [%w(- o), %w(o -)] }
  let(:radar) { double(signal: radar_signal) }
  let(:detect_all_invader_positions) { double(call: {[0, 0] => 65, [1, 1] => 0}) }
  let(:invader)  { Invader.add({form: [], color: 1}) }
  let(:service) { Services::GetMostProbablePositions.new(radar, invader) }

  it "calls Services::DetectAllInvaderPositions" do
    expect(Services::DetectAllInvaderPositions).to(
      receive(:new).with(radar, invader).and_return(detect_all_invader_positions)
    )

    service.call
  end

  it "returns most probable positions of Services::DetectAllInvaderPositions" do
    allow(Services::DetectAllInvaderPositions).to(
      receive(:new).with(radar, invader).and_return(detect_all_invader_positions)
    )

    expect(service.call).to contain_exactly([0, 0])
  end
end
