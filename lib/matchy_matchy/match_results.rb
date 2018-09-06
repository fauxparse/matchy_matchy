# frozen_string_literal: true

module MatchyMatchy
  class MatchResults
    attr_reader :targets, :candidates

    def initialize(targets:, candidates:)
      @targets = targets
      @candidates = candidates
      @matches = targets.map { |t| [t, MatchList.new(t.capacity)] }.to_h
    end

    def <<(match)
      @matches[match.target] << match
    end

    def by_target
      targets
        .map { |t| [t.object, @matches[t].map(&:candidate_object)] }
        .to_h
        .freeze
    end

    def by_candidate
      placements =
        by_target.to_a.flat_map { |t, cs| cs.map { |c| [c, t] } }.to_h
      candidates.map { |c| [c.object, placements[c.object]] }.to_h.freeze
    end
  end
end
