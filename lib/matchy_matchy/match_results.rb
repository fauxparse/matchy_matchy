module MatchyMatchy
  # An object representing the results of the stable match algorithm.
  class MatchResults
    # A list of match targets.
    attr_reader :targets

    # A list of match candidates.
    attr_reader :candidates

    # Initializes the match results with an empty list of matches.
    #
    # @param targets [Array<MatchyMatchy::Target>] Array of all possible targets
    # @param candidates [Array<MatchyMatchy::Candidate>
    #   Array of all possible candidates
    def initialize(targets:, candidates:)
      @targets = targets
      @candidates = candidates
      @matches = targets.map { |t| [t, MatchList.new(t.capacity)] }.to_h
    end

    # Adds a match to the results.
    #
    # @param match [MatchyMatchy::Match] A match to add
    # @return [MatchyMatchy::MatchResults] Self
    def <<(match)
      @matches[match.target] << match
      self
    end

    # Returns a hash where the keys are the targets in the match, and the
    # values are an ordered list of candidates for each target (if any).
    # Targets are included even if no candidates could be matched there.
    #
    # @return [Hash<MatchyMatchy::Target, Array<MatchyMatchy::Candidate>>]
    def by_target
      targets.
        map { |t| [t.object, @matches[t].map { |m| m.candidate.object }] }.
        to_h.
        freeze
    end

    # Returns a hash where the keys are the candidates in the match, and the
    # values are the targets selected for each candidate (or nil, if the
    # algorithm was unable to place the candidate).
    #
    # @return [Hash<MatchyMatchy::Target, Array<MatchyMatchy::Candidate>>]
    def by_candidate
      placements =
        by_target.to_a.flat_map { |t, cs| cs.map { |c| [c, t] } }.to_h
      candidates.map { |c| [c.object, placements[c.object]] }.to_h.freeze
    end
  end
end
