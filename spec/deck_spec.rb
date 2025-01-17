require 'rspec'
require 'deck.rb'

describe Deck do
  describe '::new_deck' do
    subject(:new_deck) { Deck.new_deck }

    it { expect(new_deck.count).to eq(52) }

    it 'returns new deck without duplicates' do
      deduped_cards = new_deck
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(deduped_cards).to eq(52)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  describe '#initialize' do
    it 'by default fills itself with 52 cards' do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end

    it 'can be initialized with an array of cards' do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it 'does not expose its cards directly' do
    expect(deck).not_to respond_to(:cards)
  end

  describe '#take' do
    # **use the front of the cards array as the top**
    it 'takes cards off the top of the deck (front of the cards array)' do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it 'removes cards from deck on take' do
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it 'does not allow you to take more cards than are in the deck' do
      expect do
        deck.take(4)
      end.to raise_error('not enough cards')
    end
  end

  describe '#return' do
    let(:more_cards) do
      [Card.new(:hearts, :four),
       Card.new(:hearts, :five),
       Card.new(:hearts, :six)]
    end

    it 'returns cards to the bottom of the deck (back of the cards array)' do
      deck.return(more_cards)
      expect(deck.count).to eq(6)
    end

    it 'does not destroy the passed array' do
      more_cards_dup = more_cards.dup
      deck.return(more_cards_dup)
      expect(more_cards_dup).to eq(more_cards)
    end

    it 'adds new cards to the bottom of the deck' do
      deck.return(more_cards)
      deck.take(3) # toss 3 cards away

      expect(deck.take(1)).to eq(more_cards[0..0])
      expect(deck.take(1)).to eq(more_cards[1..1])
      expect(deck.take(1)).to eq(more_cards[2..2])
    end
  end

  describe "#empty?" do
    it 'should call #count' do
      expect(deck).to receive(:count).and_call_original
      deck.empty?
    end

    it 'returns false when cards remain in the deck' do
      expect(deck.empty?).to be false
    end

    it 'returns true when no cards remain in the deck' do
      deck.take(3)
      expect(deck.empty?).to be true
    end
  end
end
