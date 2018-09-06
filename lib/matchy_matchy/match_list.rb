# frozen_string_literal: true

class MatchList
  include Enumerable

  def initialize(capacity)
    @matches = []
    @capacity = capacity
  end

  def <<(match)
    @matches << match
    @matches.sort!
    @matches.pop.reject! if @matches.size > @capacity
    self
  end

  def size
    @matches.size
  end

  def pop
    @matches.pop
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
