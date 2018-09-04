# frozen_string_literal: true

module MatchyMatchy
  class MatchMaker
    def initialize(targets:, candidates:)
      @matchbook = Matchbook.new
      @targets = build_targets(targets)
      @candidates = build_candidates(candidates)
    end

    def perform(by_candidate: false)
      candidates.each(&:propose_to_first_choice!)
      by_candidate ? results_by_candidate : results
    end

    private

    attr_reader :matchbook, :targets, :candidates

    def build_targets(targets)
      targets.to_a.map do |object, (preferences, capacity)|
        matchbook.target(object).tap do |target|
          target.capacity = capacity
          target.prefer(*preferences.map { |c| matchbook.candidate(c) })
        end
      end
    end

    def build_candidates(candidates)
      candidates.to_a.map do |object, preferences|
        matchbook.candidate(object).tap do |candidate|
          candidate.prefer(*preferences.map { |t| matchbook.target(t) })
        end
      end
    end

    def results
      targets.map { |t| [t.object, t.matches.map(&:candidate_object)] }.to_h
    end

    def results_by_candidate
      results
        .to_a
        .flat_map { |t, cs| cs.map { |c| [c, t] } }
        .to_h
    end

    class Matchbook
      def initialize
        @targets = {}
        @candidates = {}
      end

      def target(object)
        @targets[object] ||= Target.new(object)
      end

      def candidate(object)
        @candidates[object] ||= Candidate.new(object)
      end
    end
  end
end
