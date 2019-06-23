class Player

    attr_reader :cards, :name
    attr_accessor :game
    def initialize(deck, game, name)
        @name = name
        @cards = deck.take(7)
        @game = game
    end

    def play_turn
        puts "#{@name}'s Turn"
        show_cards
        move = get_move
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
            game.piles_to_s
            show_cards
            move = get_move
        end
        @cards += game.deck.take(1) unless @cards.count == 0
    end

    def show_cards
        cards.each_with_index do |card, i|
            print "card #{i}: #{card.to_s} | "
        end
    end

    def get_move
        return nil if cards.count == 0
        puts "\n"
        puts "Enter your move!"
        puts "enter p,5,2 to combine a pile 5 with 2"
        puts "enter c,3,1 to move card 3 to pile 1"
        print "> "
        input = parse_in(gets.chomp)
        if input[0] == "p"
            return [self.game.piles[input[1]], self.game.piles[input[2]]]
        elsif input[0] == "c"
            move = [self.cards[input[1]], self.game.piles[input[2]]]
            if move[1].valid_play?(move[0])
                return move
            else
                get_move
            end
        else
            return nil
        end
    end
    
    def parse_in(string)
        input = []
        string.split(',').each_with_index do |piece, i|
            if i == 0
                input << piece
            else
                input << piece.to_i
            end
        end
        input
    end

end