
class Pile
    attr_accessor :top_card, :bottom_card

    def initialize(card)
        @top_card = card
        @bottom_card = card
    end


    def valid_play?(card)
        return true if @top_card == nil
        card.color != @top_card.color && card.kings_corner_value + 1 == @top_card.kings_corner_value
    end
    #  adds a card to the pile
    def play(card)
        if valid_play?(card)
            @top_card = card
            @bottom_card = card if @bottom_card == nil
        else
            raise "Not valid play"
        end
    end
    #moves current pile to another pile if the current pile's bottom card 
    # can be played on the other piles top card 

    def combine_piles(other_pile)
        if other_pile.valid_play?(self.bottom_card)
            other_pile.top_card = self.top_card
            self.top_card = nil
            self.bottom_card = nil
        else
            raise "Not valid play"
        end
    end

end

class KingPile < Pile
    def initialize(card)
        @top_card = nil #defaults to nil
        @bottom_card = nil #defaults to nil

        if card.value == :king
            @top_card = card
            @bottom_card = card
        end
    end

    def combine_piles(other_pile)
        raise "CANNOT MOVE KING PILE"
    end

    def valid_play?(card)
        if @top_card.nil?
            return true if card.value == :king
            return false
        end 
        card.color != @top_card.color && card.kings_corner_value + 1 == @top_card.kings_corner_value
    end

end