module MatchyMatchy
  # A sorted list of matches with a strict capacity.
  class MatchList
    include Enumerable

    # Initializes the list.
    #
    # @param capacity [Integer] The maximum number of matches this list can hold
    def initialize(capacity = 1)
      @matches = []
      @capacity = capacity
    end

    # Pushes a match into the list.
    # The list is re-sorted and any matches that don’t fit are rejected.
    #
    # @param match [MatchyMatchy::Match]
    # @return [MatchyMatchy::MatchList] Self
    def <<(match)
      if include?(match)
        match.reject!
      else
        @matches << match
        @matches.sort!
        @matches.pop.reject! if @matches.size > @capacity
      end
      self
    end

    # Returns true if the list contains the given match.
    #
    # @param match [MatchyMatchy::Match]
    # @return [Boolean] True if the list contains this match already.
    def include?(match)
      any? { |m| m.eql?(match) }
    end

    # Returns an enumerator for the matches in the list.
    # If a block is given, iterates through the matches in order, yielding them
    # to the block.
    #
    # @yield [MatchyMatchy::Match]
    # @return Enumerator
    def each(&block)
      return enum_for(:each) unless block_given?
      to_a.each(&block)
    end

    # Returns an array of the matches in the list.
    #
    # @return [Array]
    def to_a
      @matches.dup.freeze
    end

    alias to_ary to_a
  end
end
