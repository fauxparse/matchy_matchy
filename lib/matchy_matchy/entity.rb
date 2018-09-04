# frozen_string_literal: true

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

    alias << prefer

    def include?(entity)
      preferences.include?(entity)
    end

    def index(entity)
      preferences.find_index(entity)
    end
  end
end
