module MatchyMatchy
  class Candidate
    attr_reader :object, :preferences

    def initialize(object)
      @object = object
      @preferences = []
    end

    def prefer(*entities)
      preferences.push(*entities)
      self
    end

    alias << prefer

    def include?(entity)
      preferences.include?(entity)
    end

    def eql?(other)
      object.eql?(other.object)
    end

    def index(entity)
      preferences.find_index(entity)
    end

    def to_s
      object.to_s
    end
  end
end
