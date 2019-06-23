require_relative 'card'

class Deck

    def self.new_deck
        full_deck = []
        Card.suits.each do |suit|
            Card.values.each do |value|
                full_deck << Card.new(suit, value)
            end
        end
        full_deck
    end

    def initialize(cards = Deck.new_deck)
        @cards = cards
        shuffle!
    end

    def count
        @cards.count
    end

    def empty?
        count == 0
    end
    

    def take(n)
        raise 'not enough cards' if n > @cards.count
        @cards.shift(n)
    end

    def return(new_cards)
        @cards += new_cards
    end

    def shuffle!
        @cards.shuffle!
    end

end