require 'matchy_matchy/version'
require 'matchy_matchy/candidate'
require 'matchy_matchy/target'
require 'matchy_matchy/match'
require 'matchy_matchy/matchbook'
require 'matchy_matchy/match_list'
require 'matchy_matchy/match_results'
require 'matchy_matchy/matchmaker'

# An implementation of the Stable Match algorithm.
#
# @see MatchyMatchy::MatchMaker
module MatchyMatchy
  private_constant :Candidate
  private_constant :Match
  private_constant :Matchbook
  private_constant :MatchList
  private_constant :Target
end
