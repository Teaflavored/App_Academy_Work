require_relative 'deck'
require_relative 'player'

class Game
  
  attr_accessor :players, :deck, :current_player, :pot, :current_bet
  
  def initialize
    @deck = Deck.new
    @players = [Player.new("computer", 10000, self, @deck), Player.new("comp2", 10000, self, @deck)]
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
    if player.in_round
      player.discard_action 
      player.show_hand
    end
  end
  
  def betting_phase_over?
    finished_betting? || players_remaining == 1
  end
  
  def distribute_pot(player)
    player.receive_amt(@pot)
  end
  
  def winner
    winner = nil
    
    @players.each do |player|
      next unless player.in_round
      if winner.nil? || player.hand.beats?(winner.hand)
        winner.fold! unless winner.nil?
        winner = player
      end
    end
    puts "$#{@pot} paid to #{winner.name}"
    winner
  end
  
  def finished_betting?
    @players.all? do |player|
         player.money_into_current_bet == @current_bet
    end
  end
  
  def players_remaining
    remaining_player_count = 0
    @players.each do |player|
      remaining_player_count += 1 if player.in_round
    end
    
    remaining_player_count
  end
  
  def over?
    @players.any? do |player|
      player.bank == 0
    end
  end
  
  def run
    until over?
      restart_round
      until betting_phase_over?
        each_turn
      end
      distribute_pot(winner)
    end
  end
  
  
end
game = Game.new
game.run