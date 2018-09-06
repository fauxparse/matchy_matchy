module MatchyMatchy
  class Matchbook
    def initialize
      @targets = {}
      @candidates = {}
    end

    def build_targets(targets)
      targets.to_a.map do |object, (preferences, capacity)|
        target(object).tap do |t|
          t.capacity = capacity
          t.prefer(*preferences.map { |c| candidate(c) })
        end
      end
    end

    def build_candidates(candidates)
      candidates.to_a.map do |object, preferences|
        candidate(object).tap do |c|
          c.prefer(*preferences.map { |t| target(t) })
        end
      end
    end

    def target(object)
      @targets[object] ||= Target.new(object)
    end

    def candidate(object)
      @candidates[object] ||= Candidate.new(object)
    end
  end
end
