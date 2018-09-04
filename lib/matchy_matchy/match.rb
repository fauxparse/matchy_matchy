# frozen_string_literal: true

module MatchyMatchy
  class Match
    attr_reader :target, :candidate

    def initialize(target:, candidate:)
      @target = target
      @candidate = candidate
    end

    def target_object
      target.object
    end

    def candidate_object
      candidate.object
    end

    def <=>(other)
      target.index(candidate) <=> target.index(other.candidate)
    end
  end
end
