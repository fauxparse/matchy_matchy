require 'spec_helper'

module MatchyMatchy
  RSpec.describe Candidate do
    subject(:candidate) { Candidate.new(object) }
    let(:object) { 'Darrius' }

    describe '#to_s' do
      subject { candidate.to_s }

      context 'for a string' do
        it { is_expected.to eq 'Darrius' }
      end

      context 'for a number' do
        let(:object) { 5 }
        it { is_expected.to eq '5' }
      end
    end
  end
end
