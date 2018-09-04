# frozen_string_literal: true

module MatchyMatchy
  class Candidate < Entity
    def propose_to_first_choice!
      preferences.first.propose!(self)
    end

    def rejected_by(target)
      next_target = preferences[index(target) + 1]
      next_target.propose!(self) if next_target
    end
  end
end
