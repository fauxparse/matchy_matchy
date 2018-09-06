module MatchyMatchy
  class Entity
    attr_reader :object, :preferences

    def initialize(object)
      @object = object
      @preferences = []
    end

    def prefer(*entities)
      preferences.push(*entities)
      self
    end

    def first_choice
      preferences.first
    end

    alias << prefer

    def include?(entity)
      preferences.include?(entity)
    end

    def index(entity)
      preferences.find_index(entity)
    end

    def to_s
      object.to_s
    end
  end
end
