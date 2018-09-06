module MatchyMatchy
  class MatchList
    include Enumerable

    def initialize(capacity)
      @matches = []
      @capacity = capacity
    end

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

    def include?(match)
      any? { |m| m.eql?(match) }
    end

    def each(&block)
      return enum_for(:each) unless block_given?
      to_a.each(&block)
    end

    def to_a
      @matches.dup.freeze
    end

    alias to_ary to_a
  end
end
