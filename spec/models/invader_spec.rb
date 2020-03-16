require_relative '../../models/invader'

RSpec.describe Invader do
  let(:invader) { described_class.new(invader_args) }
  let(:invader_args) { {form: [%w(- o), %w(o -)], color: 1} }

  before(:each) { described_class.class_variable_set :@@all, [] }

  ### Class methods

  describe ".add" do
    it "changes amount of invaders" do
      expect{
        described_class.add(invader_args)
      }.to(
        change { described_class.all.count }.from(0).to(1)
      )
    end

    it "creates new instance" do
      expect(described_class).to receive(:new).with(invader_args)
      described_class.add(invader_args)
    end
  end

  describe ".all" do
    it "returns array of instances" do
      expect(described_class.all).to contain_exactly(invader)
    end
  end

  ### Instance methods

  describe "#height" do
    it "returns index of last element of form" do
      expect(invader.height).to eq(1)
    end
  end

  describe "#width" do
    it "returns index of last element of nested element in form" do
      expect(invader.width).to eq(1)
    end
  end

  describe "#get" do
    it "returns char at specific position" do
      expect(invader.get(1, 1)).to eq('-')
    end
    it "returns nil if indexes out of bounds" do
      expect(invader.get(2, 2)).to be_nil
    end
  end

  describe "#size" do
    it "returns amount of 'o' chars" do
      expect(invader.size).to eq(2)
    end
  end

  describe "#each_start_from" do
    it { expect{ |b| invader.each_start_from(0,0, &b) }.to yield_control.twice }
    it { expect{ |b| invader.each_start_from(0,1, &b) }.to yield_control.once }
    it { expect{ |b| invader.each_start_from(1,1, &b) }.to_not yield_control }
    it { expect{ |b| invader.each_start_from(0,1, &b) }.to yield_with_args('o', 1, 0) }
  end
end
