# frozen_string_literal: true

module MatchyMatchy
  class MatchMaker
    def initialize(targets:, candidates:)
      @matchbook = Matchbook.new
      @targets = matchbook.build_targets(targets)
      @candidates = matchbook.build_candidates(candidates)
      @matches = MatchResults.new(targets: @targets, candidates: @candidates)
    end

    def perform
      candidates.each { |candidate| propose(candidate) }
      @matches
    end

    private

    attr_reader :matchbook, :targets, :candidates

    def propose(candidate, index = 0)
      return unless index < candidate.preferences.size

      proposed = match(candidate, index)
      if proposed.mutual?
        @matches << proposed
      else
        proposed.reject!
      end
    end

    def match(candidate, index)
      Match
        .new(candidate: candidate, index: index)
        .on(:reject) { propose(candidate, index + 1) }
    end
  end
end
