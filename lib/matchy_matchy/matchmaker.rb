module MatchyMatchy
  # Implements the Stable Match algorithm ovver a given set of candidates and
  # targets.
  class MatchMaker
    # Initializes the MatchMaker.
    # You must specify a list of +targets+ (objects “offering” places) and
    # +candidates+ (objects “seeking” places). These can be any type of object:
    # they are wrapped internally, but you should never have to deal with that.
    #
    # @example
    #   match_maker = MatchyMatchy::MatchMaker.new(
    #     targets: {
    #       'Gryffindor' => [['Hermione', 'Ron', 'Harry'], 2],
    #       'Ravenclaw'  => [['Hermione'], 1],
    #       'Hufflepuff' => [['Neville', 'Hermione'], 2],
    #       'Slytherin'  => [['Harry', 'Hermione', 'Ron', 'Neville'], 4]
    #     },
    #     candidates: {
    #       'Harry'    => ['Gryffindor', 'Slytherin'],
    #       'Hermione' => ['Ravenclaw', 'Gryffindor'],
    #       'Ron'      => ['Gryffindor'],
    #       'Neville'  => ['Hufflepuff', 'Gryffindor', 'Ravenclaw', 'Slytherin']
    #     }
    #   )
    #
    # The +target+ and +candidate+ parameters look similar, but the values in
    # the +target+ hash have an extra number, which is the maximum capacity of
    # that target (the total number of candidates it can accept). The capacity
    # may also be omitted, in which case it defaults to 1; that is:
    #
    #   {
    #     'Gryffindor' => ['Hermione', 'Ron', 'Harry'],
    #     'Ravenclaw'  => ['Hermione'],
    #     'Hufflepuff' => ['Neville', 'Hermione'],
    #     'Slytherin'  => ['Harry', 'Hermione', 'Ron', 'Neville'],
    #   }
    #
    # ...is equivalent to:
    #
    #   {
    #     'Gryffindor' => [['Hermione', 'Ron', 'Harry'], 1],
    #     'Ravenclaw'  => [['Hermione'], 1],
    #     'Hufflepuff' => [['Neville', 'Hermione'], 1],
    #     'Slytherin'  => [['Harry', 'Hermione', 'Ron', 'Neville'], 1]
    #   }
    def initialize(targets:, candidates:)
      @matchbook = Matchbook.new
      @targets = matchbook.build_targets(targets)
      @candidates = matchbook.build_candidates(candidates)
      @matches = MatchResults.new(targets: @targets, candidates: @candidates)
    end

    # Kicks off the match.
    # Iterates through the candidates in order, proposing each to their
    # first-choice target. If this match is rejected, the candidate is proposed
    # to their next choice of candidate (if any).
    #
    # The running time of the algorithm is proportional to the number of
    # candidates and targets in the system, but is guaranteed to finish and
    # yield the same result for the same input.
    #
    # @return [MatchyMatchy::MatchResults] A +MatchResults+ object representing
    #   the outcome of the algorithm.
    def perform
      candidates.each { |candidate| propose(candidate) }
      @matches
    end

    private

    attr_reader :matchbook, :targets, :candidates

    def propose(candidate, index = 0)
      return unless index < candidate.preferences.size

      proposed = match(candidate, index)
      if proposed.mutual?
        @matches << proposed
      else
        proposed.reject!
      end
    end

    def match(candidate, index)
      Match.
        new(candidate: candidate, index: index).
        on(:reject) { propose(candidate, index + 1) }
    end
  end
end
