require_relative "deck"
require_relative "pile"
require_relative "ai_player"
require_relative "player"

class Game
    attr_accessor :king_piles, :reg_piles, :deck, :players
    def initialize
        @deck = Deck.new

        @king_piles = []
        @reg_piles = []
        @players = []
        @current_turn = 0

        (4).times do
            @reg_piles << Pile.new(deck)
            @king_piles << KingPile.new
        end
    end

    def create_players(num = 4)
        num.times {self.players << AIPlayer.new(self.deck, self)}
        # self.players << Player.new(self.deck, self, "Daniel")
        # self.players << Player.new(self.deck, self, "Lil Gravy")
    end

    def start_turn
        players[@current_turn % players.length].play_turn
        @current_turn += 1
    end

    def start_game
        until over?
            piles_to_s
            start_turn
        end
        winner = self.players.select {|player| player.cards.count == 0}
        
        piles_to_s
        puts "\n"
        puts "Jarvis won the game!" if winner[0].is_a? (AIPlayer)
        puts "#{winner[0].name} won the game!" if winner[0].is_a?(Player)
    end

    def over? 
        self.players.any? {|player| player.cards.count == 0}
    end

    def piles_to_s
        puts ""
        self.king_piles.each_with_index do |pile, i|
            print "pile #{i} KING PILE: "
            print "Top: "
            print "#{pile.top_card.to_s} " unless pile.top_card.nil?
            print "No Card! " if pile.top_card.nil?
            print "Bottom: "
            print "#{pile.bottom_card.to_s}" unless pile.bottom_card.nil?
            print "No Card!" if pile.bottom_card.nil?
            puts ""
        end

        self.reg_piles.each_with_index do |pile, i|
            print "pile #{i + 4}  REG PILE: "
            print "Top: "
            print "#{pile.top_card.to_s} " unless pile.top_card.nil?
            print "No Card! " if pile.top_card.nil?
            print "Bottom: "
            print "#{pile.bottom_card.to_s}" unless pile.bottom_card.nil?
            print "No Card!" if pile.bottom_card.nil?
            puts ""
        end
    end

    def piles
        king_piles + reg_piles
    end

end

kingCorner = Game.new
kingCorner.create_players
kingCorner.start_game