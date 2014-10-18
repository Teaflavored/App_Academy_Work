require_relative 'hand'

class Player
  class InputError < StandardError; end
  
  
  attr_reader :name
  attr_accessor :hand, :bank, :in_round, :money_into_current_bet
  
  def initialize(name, bankroll, game, deck)
    @game = game
    @name = name
    @bank = bankroll
    @money_into_current_bet = 0
  end
  
  def reset_betting_money
    @money_into_current_bet = 0
  end
  
  def deal_hand
    @hand = Hand.new(@game.deck)    
  end
    
  def discard_action
    input = get_user_input_for_discard
    if input != 'q'
      discard_turn(input.split(",").map(&:to_i), @game.deck)
    end
    
    nil
  end
  
  def show_hand
    puts "Your hand contains a #{@hand.worth}"
    puts @hand.to_s
  end
    
  def get_user_input_for_discard
    loop do
      puts show_hand
      puts "Which cards would you like to discard?"
      puts "Enter positions separated by commas, enter q to hold"
      input = gets.chomp
      return input if input == 'q' || input.match(/\A[0-4]{1}(,[0-4]{1}){1,2}\z/)
      puts "invalid input"
    end
  end
  
  def action
    input = get_user_input_for_action
    case input
    when 'c'
      call(@game.current_bet - @money_into_current_bet)
    when 'f'
      fold!
    when 'r'
      begin
        raise_amount = get_user_input_for_raise
        bet_amt(raise_amount + @game.current_bet - @money_into_current_bet)
        @game.current_bet += raise_amount
      rescue
        retry
      end
    end
  end
  
  
  
  def get_user_input_for_raise
    begin
      puts "How much would you like to raise?"
      input = gets.chomp
      raise InputError.new("Not a valid input") unless Integer(input)
      return input.to_i
    rescue InputError => e
      puts e
      retry
    end
  end
  
  def get_user_input_for_action
    begin
      puts "What would you like to do? f for fold, c for call, r for raise"
      input = gets.chomp
      raise InputError.new("Not a valid input") unless ["c","f","r"].include?(input)
      return input
    rescue InputError => e
      puts e
      retry
    end
  end
  
  def fold!
    @in_round = false
  end
  
  def discard_turn(card_pos, deck)
    @hand.discard(card_pos)
    @hand.draw_from_deck(deck, card_pos.count)
  end
  
  def bet_amt(amt)
    raise if amt > @bank
    @bank -= amt
    @money_into_current_bet += amt
    @game.pot += amt
  end
  
  def receive_amt(amt)
    @bank += amt
  end
  
  def call(amt)
    raise if amt > @bank
    @bank -= amt
    @money_into_current_bet += amt
    @game.pot += amt
  end
end