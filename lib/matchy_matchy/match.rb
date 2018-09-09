require 'cry'

module MatchyMatchy
  # Represents a proposed match in the Stable Match algorithm.
  class Match
    include Comparable
    include Cry

    # Returns the candidate being matched.
    attr_reader :candidate

    # Returns the (zero-based) index of this match in the candidate’s
    # preferences.
    attr_reader :index

    # Initializes the match with a candidate and an index.
    #
    # @param candidate [MatchyMatchy::Candidate] A candidate
    # @param index [Integer] (Zero-based) index of preference to try.
    #  Defaults to 0, indicating the candidate’s first choice.
    def initialize(candidate:, index: 0)
      raise ArgumentError, "candidate does not have #{i+1} choices" \
        if index > candidate.preferences.size

      @candidate = candidate
      @index = index
    end

    # Returns the target of the match by looking it up in the candidate’s
    # preferences
    #
    # @return [MatchyMatchy::Target] The target object
    def target
      candidate.preferences[index]
    end

    # Returns true if two matches are equal.
    # True if the two matches’ candidates and targets are identical,
    # respectively.
    #
    # @return [Boolean] True if `self` and `other` are equal, false otherwise.
    def eql?(other)
      target.eql?(other.target) && candidate.eql?(other.candidate)
    end

    # Compares two matches, in order of preference within the target.
    # For comparison to be meaningful, the two matches must have the same
    # target, and both matches’ candidates must be preferred by the target.
    #
    # @param other [MatchyMatchy::Match] A second match for comparison
    # @return [Integer]
    #   * negative if `self < other`
    #   * 0 if `self == other`
    #   * positive if `self > other`
    def <=>(other)
      raise ArgumentError, "matches must have the same target" \
        unless target == other.target
      target.index(candidate) <=> target.index(other.candidate)
    end

    # Returns true if the target also prefers the candidate.
    #
    # @return True if target’s preferences include this match’s candidate,
      #   false otherwise.
    def mutual?
      target.include?(candidate)
    end

    # Rejects the match.
    # This may be handled by attaching a block with Cry’s `on` semantics:
    #
    #   match.on(:reject) { do_something }
    def reject!
      publish!(:reject)
    end
  end
end
