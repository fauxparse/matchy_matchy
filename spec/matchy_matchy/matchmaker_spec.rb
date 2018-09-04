# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MatchyMatchy::MatchMaker do
  subject { matchmaker.perform }
  let(:matchmaker) do
    MatchyMatchy::MatchMaker.new(
      candidates: {
        'Arthur'  => %w[City],
        'Sunny'   => %w[City Mercy],
        'Joseph'  => %w[City General Mercy],
        'Latha'   => %w[Mercy City General],
        'Darrius' => %w[City Mercy General]
      },
      targets: {
        'Mercy'   => [%w[Darrius Joseph], 2],
        'City'    => [%w[Darrius Arthur Sunny Latha Joseph], 2],
        'General' => [%w[Darrius Arthur Joseph Latha], 2]
      }
    )
  end

  context 'by target' do
    let(:results) do
      {
        'Mercy'   => [],
        'City'    => %w[Darrius Arthur],
        'General' => %w[Joseph Latha]
      }
    end

    it { is_expected.to eq results }
  end
end
