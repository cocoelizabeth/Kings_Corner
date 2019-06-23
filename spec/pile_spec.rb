require 'rspec'
require "pile.rb"
require 'deck.rb'

describe Pile do 
    subject(:pile) { Pile.new(card) }
    let(:card) { Card.new(:clubs, :deuce) } 

    describe '#initialize' do
        it 'correctly sets the top card' do
            expect(pile.top_card).to eq(card)
        end 
        it 'correctly sets the bottom card' do
            expect(pile.bottom_card).to eq(card)
        end 
    end 

    describe "#valid_play?" do
        it 'approves playing a card of one rank lower and of a different color' do
            expect(pile.valid_play?(Card.new(:hearts, :ace))).to eq(true)
        end 

        it 'rejects a matching color play' do
            expect(pile.valid_play?(Card.new(:clubs, :ace))).to eq(false)
        end

        it 'rejects a higher rank play' do
            expect(pile.valid_play?(Card.new(:hearts, :three))).to eq(false)
        end
    end

    describe "#play" do

        it "resets top card on valid play" do 
            played_card = Card.new(:hearts, :ace)

            pile.play(played_card)
            expect(pile.top_card).to eq(played_card)
        end

        it "sets bottom card if the pile has no bottom card" do
            played_card = Card.new(:hearts, :ace)
            pile.bottom_card = nil

            pile.play(played_card)
            expect(pile.bottom_card).to eq(played_card)
        end 

         it 'rejects an invalid play' do
            expect do
                pile.play(Card.new(:spades, :queen))
            end.to raise_error('Not valid play')
        end
    end 

    describe "#combine_piles" do

     #moves current pile to another pile if the current pile's bottom card 
    # can be played on the other piles top card 

        it "resets top card of other pile on valid play" do 
            card = Card.new(:diamonds, :three)
            other_pile = Pile.new(card)
            tc = pile.top_card.dup

            pile.combine_piles(other_pile)
            expect(other_pile.top_card).to eq(tc)
        end

        it "leaves an empty spot where the moved pile was" do
            card = Card.new(:diamonds, :three)
            other_pile = Pile.new(card)

            pile.combine_piles(other_pile)
            expect(pile.top_card).to eq(nil)
            expect(pile.bottom_card). to eq(nil)
        end 

         it 'rejects an invalid play' do
            card = Card.new(:clubs, :three)
            other_pile = Pile.new(card)
            
            expect do
                pile.combine_piles(other_pile)
            end.to raise_error('Not valid play')
        end
    end 
end


describe KingPile do 
    
    describe "#initialize" do

        it 'sets all King corners to a default of empty' do
            card = Card.new(:clubs, :deuce)
            king_pile = KingPile.new(card)
            expect(king_pile.top_card).to eq(nil)
            expect(king_pile.bottom_card).to eq(nil)
        end 

        it 'allows a King to be placed' do
            card = Card.new(:clubs, :king)
            king_pile = KingPile.new(card)
            expect(king_pile.top_card).to eq(card)
            expect(king_pile.bottom_card).to eq(card)
        end   
    end

    describe "#combine_piles" do
        it 'does not allow king to be added to a pile' do
            card = Card.new(:clubs, :king)
            other_pile = KingPile.new(card)
            king_pile = KingPile.new(Card.new(:clubs, :king))

            expect do
                king_pile.combine_piles(other_pile)
            end.to raise_error('CANNOT MOVE KING PILE')
        end
    end

    describe "#valid_play?" do 
        it 'returns true if the card is a king and the corner is empty' do
            card = Card.new(:clubs, :king)
            king_pile = KingPile.new(Card.new(:clubs, :deuce))


            expect(king_pile.valid_play?(card)).to eq(true)
        end

        it 'returns true if the card'
        it 'returns false if the card is not a king' do
            card = Card.new(:clubs, :deuce)
            king_pile = KingPile.new(card)

            expect(king_pile.valid_play?(card)).to eq(true)
        end

        it 'returns false if the corner pile is not empty' do
            card
        end
    end

    end

    
end

