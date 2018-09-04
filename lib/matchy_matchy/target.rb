# frozen_string_literal: true

module MatchyMatchy
  class Target < Entity
    attr_reader :matches
    attr_accessor :capacity

    def initialize(object, capacity: 1)
      super(object)
      @matches = []
      @capacity = capacity
    end

    def propose!(candidate)
      if include?(candidate)
        match(candidate)
        reject(matches.pop.candidate) if matches.size > capacity
      else
        reject(candidate)
      end
    end

    private

    def match(candidate)
      matches << Match.new(target: self, candidate: candidate)
      matches.sort!
    end

    def reject(candidate)
      candidate.rejected_by(self)
    end
  end
end
