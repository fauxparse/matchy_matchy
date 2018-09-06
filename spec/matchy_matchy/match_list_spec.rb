require 'spec_helper'

module MatchyMatchy
  RSpec.describe MatchList do
    class Item
      attr_reader :number

      def initialize(number)
        @number = number
      end

      def <=>(other)
        number <=> other.number
      end

      def inspect
        number.to_s
      end
    end

    subject(:list) { MatchList.new(2) }
    let(:one) { Item.new(1) }
    let(:two) { Item.new(2) }
    let(:three) { Item.new(3) }

    describe '#<<' do
      it 'rejects largest item if over capacity' do
        expect(one).not_to receive(:reject!)
        expect(two).not_to receive(:reject!)
        expect(three).to receive(:reject!)

        list << three
        expect(list.to_a).to eq [three]
        list << two
        expect(list.to_a).to eq [two, three]
        list << one
        expect(list.to_a).to eq [one, two]
      end

      it 'does not accept the same element multiple times' do
        list << one
        expect(one).to receive(:reject!)
        expect { list << one }.not_to change { list.to_a }
      end
    end

    describe '#include?' do
      before { list << one }
      it { is_expected.to include one }
      it { is_expected.not_to include two }
    end

    describe '#to_a' do
      subject { list.to_a }
      it { is_expected.to be_frozen }
    end
  end
end
