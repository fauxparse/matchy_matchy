module MatchyMatchy
  # Represents a target in the Stable Match algorithm.
  # A target is largely the same as a candidate, with the addition of the
  # concept of “capacity”: how many candidates the target is willing to accept.
  class Target < Candidate
    attr_accessor :capacity

    # Initializes the target with an object to wrap, and a capacity.
    #
    # @param object [Object] The object represented by this target
    # @param capacity [Integer] The target’s maximum capacity
    def initialize(object, capacity: 1)
      super(object)
      @capacity = capacity
    end
  end
end
