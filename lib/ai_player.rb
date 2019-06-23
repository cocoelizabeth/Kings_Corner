
class AIPlayer
    attr_reader :cards
    attr_accessor :game
    def initialize(deck, game)
        @cards = deck.take(7)
        @game = game
    end

    def play_turn
        show_cards
        move = get_valid_move_with_pile
        until move.nil?
            puts "\n"
            if move[0].is_a?(Card)
                card, pile = move
                puts "Place card: #{pile.top_card} #{card}"
                pile.play(card)
                @cards.delete(card)
            else
                pile1, pile2 = move
                pile1.add_to(pile2)
                puts "Move Pile: #{pile2.top_card} #{pile1.bottom_card}"
            end
            move = get_valid_move_with_pile
        end
        @cards += game.deck.take(1) unless @cards.count == 0
    end

    def show_cards
        cards.each_with_index do |card, i|
            print "card #{i}: #{card.to_s} | "
        end
    end

    def get_valid_move_with_pile
        return nil if cards.count == 0
        self.game.reg_piles.each_with_index do |pile1|
            self.game.piles.each_with_index do |pile2|
                return [pile1, pile2] if !pile1.bottom_card.nil? && !pile2.top_card.nil? && pile2.valid_play?(pile1.bottom_card) 
            end
        end

        self.game.piles.each do |pile|
            @cards.each do |card|
                return [card, pile] if !card.nil? && pile.valid_play?(card)
            end
        end

        nil
    end

end