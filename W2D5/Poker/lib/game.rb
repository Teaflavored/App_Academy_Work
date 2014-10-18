require_relative 'deck'
require_relative 'player'

class Game
  
  attr_accessor :players, :deck, :current_player, :pot, :current_bet
  
  def initialize
    @deck = Deck.new
    @players = [Player.new("computer", 10000, self, @deck), Player.new("comp2", 10000, self, @deck)]
    restart_round
  end
  
  def restart_round
    @deck = Deck.new
    @deck.shuffle!
    
    @players.each do |player|
      player.reset_betting_money
      player.in_round = true
      player.deal_hand
    end
    
    @current_bet = 5
    @pot = 0
    
  end
  
  def each_turn
    @players.each do |player|
      play_turn(player) if player.in_round
    end
  end
  
  def play_turn(player)
    puts "*****************************************************"
    puts "You have $#{player.bank}, your name is #{player.name}"
    player.show_hand
    puts "Current bet is #{@current_bet}, current pot is #{@pot}, you have bet $#{player.money_into_current_bet} towards the current bet"
    player.action
    puts "Current bet is #{@current_bet}, current pot is #{@pot}, you have bet $#{player.money_into_current_bet} towards the current bet"
    player.discard_action if player.in_round
    player.show_hand
  end
  
  def round_over?
    @players.all? do |player|
      player.money_into_current_bet == @current_bet
    end
  end
  
  def over?
    false
  end
  
  def run
    until over?
      until round_over?
        each_turn
      end
    end
  end
  
  
end
game = Game.new
game.run