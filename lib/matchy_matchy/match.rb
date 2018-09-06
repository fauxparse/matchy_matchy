require 'cry'

module MatchyMatchy
  class Match
    include Comparable
    include Cry

    attr_reader :candidate, :index

    def initialize(candidate:, index:)
      @candidate = candidate
      @index = index
    end

    def target
      candidate.preferences[index]
    end

    def eql?(other)
      target.eql?(other.target) && candidate.eql?(other.candidate)
    end

    def <=>(other)
      target.index(candidate) <=> target.index(other.candidate)
    end

    def mutual?
      target.include?(candidate)
    end

    def reject!
      publish!(:reject)
    end
  end
end
