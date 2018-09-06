require 'spec_helper'

RSpec.describe MatchyMatchy::Matchbook do
  subject(:matchbook) { MatchyMatchy::Matchbook.new }

  it 'holds a cache of candidates and targets' do
    expect(MatchyMatchy::Candidate).
      to receive(:new).exactly(4).times.and_call_original
    expect(MatchyMatchy::Target).
      to receive(:new).exactly(3).times.and_call_original

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
