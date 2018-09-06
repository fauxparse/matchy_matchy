module MatchyMatchy
  class Target < Candidate
    attr_accessor :capacity

    def initialize(object, capacity: 1)
      super(object)
      @capacity = capacity
    end
  end
end
