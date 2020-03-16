require_relative '../../services/detect_invader_position'
require_relative '../../models/radar_signal'
require_relative '../../models/invader'
require_relative '../../constants'

RSpec.describe Services::DetectInvaderPosition do
  let(:signal) do
    [
      "----o-o-----o-o---".split(''),
      "-------oo-oo------".split(''),
      "----o-------------".split(''),
      "---ooo-----o--oo-o".split(''),
      "o--o--o-o-o------o".split(''),
      "-----o-ooooo---o--".split(''),
      "-o-oo--ooo-oo-----".split(''),
      "---ooooooo-ooo-oo-".split(''),
      "o--oooo--ooo-o----".split(''),
      "o--o-o-----o-o----".split(''),
      "o-----oo-oo---o--o".split(''),
      "---o--o-o---o-----".split(''),
      "----------o-o-o--o".split('')
    ]
  end
  let(:radar) { RadarSignal.new(signal) }
  let(:invader) { Invader.new(INVADER_1) }

  it "doesn't find matches" do
    service = described_class.new(radar, invader, 1, 1)
    expect(service.call).to eq(0)
  end

  it "finds matches" do
    service = described_class.new(radar, invader, 10, 13)
    expect(service.call).to eq(82)
  end
end
