require 'spec_helper'

RSpec.describe MatchyMatchy::MatchResults do
  subject(:results) do
    MatchyMatchy::MatchResults.new(targets: targets, candidates: candidates)
  end

  let(:candidates) do
    [
      MatchyMatchy::Candidate.new(:good),
      MatchyMatchy::Candidate.new(:bad),
    ]
  end

  let(:targets) do
    [
      MatchyMatchy::Target.new(:yum),
      MatchyMatchy::Target.new(:yuck),
    ]
  end

  before do
    candidates.first.prefer(targets.first)
    targets.first.prefer(*candidates)
    results << MatchyMatchy::Match.new(candidate: candidates.first, index: 0)
  end

  describe '#by_target' do
    subject { results.by_target }
    it { is_expected.to eq(yum: [:good], yuck: []) }
  end

  describe '#by_candidate' do
    subject { results.by_candidate }
    it { is_expected.to eq(good: :yum, bad: nil) }
  end
end
