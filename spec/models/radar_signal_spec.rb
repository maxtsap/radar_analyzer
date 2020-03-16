require_relative '../../models/radar_signal'

RSpec.describe RadarSignal do
  let(:signal) { [%w(- o), %w(o -)] }
  let(:radar_signal) { described_class.new(signal) }

  describe "#height" do
    it "returns index of last element of signal" do
      expect(radar_signal.height).to eq(1)
    end
  end

  describe "#width" do
    it "returns index of last element of nested element in signal" do
      expect(radar_signal.width).to eq(1)
    end
  end

  describe "#get" do
    it "returns char at specific position" do
      expect(radar_signal.get(1, 1)).to eq('-')
    end
    it "returns nil if indexes out of bounds" do
      expect(radar_signal.get(2, 2)).to be_nil
    end
  end
end
