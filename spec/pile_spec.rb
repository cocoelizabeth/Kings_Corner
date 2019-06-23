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
end