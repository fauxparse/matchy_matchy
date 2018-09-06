module MatchyMatchy
  class Matchbook
    def initialize
      @targets = {}
      @candidates = {}
    end

    def build_targets(targets)
      targets.to_a.map do |object, row|
        preferences, capacity = parse_target_row(row)
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

    private

    def target(object)
      @targets[object] ||= Target.new(object)
    end

    def candidate(object)
      @candidates[object] ||= Candidate.new(object)
    end

    def parse_target_row(row)
      return row if row.size == 2 &&
          row.first.respond_to?(:map) &&
          row.last.respond_to?(:zero?)
      [row, 1]
    end
  end
end
