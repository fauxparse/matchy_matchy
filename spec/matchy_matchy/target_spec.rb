require 'spec_helper'

RSpec.describe MatchyMatchy::Target do
  subject(:target) { MatchyMatchy::Target.new(object, capacity: capacity) }
  let(:object) { 'City' }
  let(:capacity) { 2 }

  describe '#capacity' do
    subject { target.capacity }
    it { is_expected.to eq 2 }

    it 'defaults to 1' do
      expect(MatchyMatchy::Target.new(object).capacity).to eq 1
    end
  end
end
