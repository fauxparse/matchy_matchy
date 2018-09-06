# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MatchyMatchy::MatchMaker do
  subject(:results) { matchmaker.perform }

  let(:candidates) do
    {
      'Arthur'  => %w[City],
      'Sunny'   => %w[City Mercy],
      'Joseph'  => %w[City General Mercy],
      'Latha'   => %w[Mercy City General],
      'Darrius' => %w[City Mercy General]
    }
  end

  let(:targets) do
    {
      'Mercy'   => [%w[Darrius Joseph], 2],
      'City'    => [%w[Darrius Arthur Sunny Latha Joseph], 2],
      'General' => [%w[Darrius Arthur Joseph Latha], 2]
    }
  end

  let(:matchmaker) do
    MatchyMatchy::MatchMaker.new(targets: targets, candidates: candidates)
  end

  context 'by target' do
    subject { results.by_target }
    let(:expected_results) do
      {
        'Mercy'   => [],
        'City'    => %w[Darrius Arthur],
        'General' => %w[Joseph Latha]
      }
    end

    it { is_expected.to eq expected_results }

    context 'with confusing targets and candidates' do
      let(:candidates) do
        {
          1 => [2],
          2 => [2, 1],
          3 => [2, 3, 1],
          4 => [1, 2, 3],
          5 => [2, 1, 3]
        }
      end

      let(:targets) do
        {
          1 => [[5, 3], 2],
          2 => [[5, 1, 2, 4, 3], 2],
          3 => [[5, 1, 3, 4], 2]
        }
      end

      let(:expected_results) do
        {
          1 => [],
          2 => [5, 1],
          3 => [3, 4]
        }
      end

      it { is_expected.to eq expected_results }
    end
  end

  context 'by candidate' do
    subject { results.by_candidate }
    let(:expected_results) do
      {
        'Arthur'  => 'City',
        'Sunny'   => nil,
        'Joseph'  => 'General',
        'Latha'   => 'General',
        'Darrius' => 'City'
      }
    end

    it { is_expected.to eq expected_results }
  end
end
