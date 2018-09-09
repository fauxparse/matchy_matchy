module MatchyMatchy
  # Represents a candidate in the Stable Match algorithm.
  # Since the concept of a wrapped object with an ordered list of preferences
  # is common to both candidates and targets, +Target+ inherits directly
  # from +Candidate+, so when reading this documentation in that context,
  # the words ‘candidate’ and ‘target’ should be reversed.
  class Candidate
    # Returns the wrapped object being represented by this candidate
    attr_reader :object

    # Returns an ordered list of this candidate’s preferred targets
    attr_reader :preferences

    # @param object The object being represented by this candidate.
    def initialize(object)
      @object = object
      @preferences = []
    end

    # Indicates an order of preference for this candidate’s matches.
    # The given targets will be appended to any existing preferences.
    # Returns +self+ to maintain the semantics of `<<`.
    #
    # @param targets [Array] One or more targets, in order of preference.
    def prefer(*targets)
      preferences.push(*targets)
      self
    end

    alias << prefer

    # Returns true if this candidate has expressed a preference for
    # the given target, false otherwise.
    #
    # @param target A target entity
    # @return [Boolean] True if the candidate prefers the target
    def include?(target)
      preferences.include?(target)
    end

    # Returns true if two candidates’ objects are equal, false otherwise.
    #
    # @param other [MatchyMatchy::Candidate] Another object for comparison
    # @return [Boolean] True if the two candidates are equal, false otherwise
    def eql?(other)
      object.eql?(other.object)
    end

    # Determine the index of the given target within the candidate’s
    # preferences.
    #
    # @param target [MatchyMatchy::Candidate] A target entity to search for
    # @return [Integer] The target’s position, or +nil+
    def index(target)
      preferences.find_index(target)
    end

    # Returns a string representation of the candidate.
    # Delegates to the wrapped object.
    #
    # @return [String] a string for display
    def to_s
      object.to_s
    end
  end
end
