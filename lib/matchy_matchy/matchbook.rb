module MatchyMatchy
  # Small class to maintain a cache of candidates and targets, for use by the
  # +MatchMaker+. Ensures the following conditions:
  #
  # * Candidates and targets are kept separate, even if the objects they wrap
  #   are identical
  # * Exactly one +Candidate+ or +Target+ instance is created for each object
  #   considered by the +MatchMaker+
  # * Objects are not double-wrapped
  class Matchbook
    # Initializes the Matchbook with an empty cache.
    def initialize
      @targets = {}
      @candidates = {}
    end

    # Builds a list of targets for the +MatchMaker+.
    # The parameter is a hash of unwrapped target objects to their preferred
    # candidates and maximum capacity (a 2-tuple expressed as an array):
    #
    # @example With explicit capacities
    #   matchbook.build_targets(
    #     'Gryffindor' => [['Hermione', 'Ron', 'Harry'], 2],
    #     'Ravenclaw'  => [['Hermione'], 1],
    #     'Hufflepuff' => [['Neville', 'Hermione'], 2],
    #     'Slytherin'  => [['Harry', 'Hermione', 'Ron', 'Neville'], 4]
    #   )
    #
    # The capacity may also be omitted, in which case it defaults to 1:
    #
    # @example With explicit capacities
    #   matchbook.build_targets(
    #     'Gryffindor' => ['Hermione', 'Ron', 'Harry'],
    #     'Ravenclaw'  => ['Hermione'],
    #     'Hufflepuff' => ['Neville', 'Hermione'],
    #     'Slytherin'  => ['Harry', 'Hermione', 'Ron', 'Neville'],
    #   )
    #
    # @param targets [Hash<Object, Array<Object>>]
    #   Hash of target objects to a list of their preferred candidates
    def build_targets(targets)
      targets.to_a.map do |object, row|
        preferences, capacity = parse_target_row(row)
        target(object).tap do |t|
          t.capacity = capacity
          t.prefer(*preferences.map { |c| candidate(c) })
        end
      end
    end

    # Builds a list of candidates for the +MatchMaker+.
    # The parameter is a hash of unwrapped canditate objects to their preferred
    # targets.
    #
    # @example
    #   matchbook.build_candidates(
    #     'Harry'    => ['Gryffindor', 'Slytherin'],
    #     'Hermione' => ['Ravenclaw', 'Gryffindor'],
    #     'Ron'      => ['Gryffindor'],
    #     'Neville'  => ['Hufflepuff', 'Gryffindor', 'Ravenclaw', 'Slytherin']
    #   )
    #
    # @param candidates [Hash<Object, Array<Object>>]
    #   Hash of candidate objects to a list of their preferred targets
    def build_candidates(candidates)
      candidates.to_a.map do |object, preferences|
        candidate(object).tap do |c|
          c.prefer(*preferences.map { |t| target(t) })
        end
      end
    end

    private

    def target(object)
      return object if object.is_a?(Target)
      @targets[object] ||= Target.new(object)
    end

    def candidate(object)
      return object if object.is_a?(Candidate)
      @candidates[object] ||= Candidate.new(object)
    end

    def parse_target_row(row)
      return row if row.size == 2 &&
          row.first.respond_to?(:map) &&
          row.last.respond_to?(:zero?)
      [row, 1]
    end
  end
end
