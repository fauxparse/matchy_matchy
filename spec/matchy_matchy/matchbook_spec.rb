require 'spec_helper'

module MatchyMatchy
  RSpec.describe Matchbook do
    subject(:matchbook) { Matchbook.new }

    it 'holds a cache of candidates and targets' do
      expect(Candidate).to receive(:new).exactly(4).times.and_call_original
      expect(Target).to receive(:new).exactly(3).times.and_call_original

      matchbook.build_candidates(
        a: %i[x y z],
        b: %i[z x],
        c: %i[x z y],
        d: %i[y],
      )

      matchbook.build_targets(
        x: [%i[a b c d], 2],
        y: [%i[c a d], 2],
        z: [%i[b d], 2],
      )
    end
  end
end
