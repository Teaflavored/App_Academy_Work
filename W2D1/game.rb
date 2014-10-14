require_relative "board.rb"
require "yaml"
require 'io/console'

class Game
  ALPHABET = ("A".."Z").to_a
  def initialize(width, height, num_bombs)
    @board = Board.new(width, height, num_bombs)
    @start_pos = [0,0]
  end
  
  def is_over?
    @board.over?
  end
  

  def save_file
    File.open("save_game.txt", "w") do |f|
      f.puts self.to_yaml
    end
    puts "Succesfully saved."
    exit
  end
  
  def load_file(filename)
    yaml_str = File.read(filename)
    YAML.load(yaml_str)
  end
  
  def start_game
    puts "Welcome to minesweeper, load a file? (y/n)"
    option = gets.chomp
    if option == 'y'
      load_file('save_game.txt').play
    else
      play
    end
  end
  
  def play
    begin 
      until is_over?
        system("clear")
        @board.display_board
        new_action
      end
      system("clear")
      @board.display_board
      puts "You Win!"
    rescue MinesweeperError
      puts "You Lose!"
    end
  end
  

  
  def update_cursor(new_pos)
    @board.get_tile_at_pos(@start_pos).toggle_current
    @board.get_tile_at_pos(new_pos).toggle_current
    system("clear")
    @board.display_board
    @start_pos = new_pos
  end
  
  def new_action 
    actioned = false
    until actioned
      input = $stdin.getch
      case input
      when "a", "s", "d", "w"
        move_cursor(input)
      when "r"
        @board.reveal_tile(@start_pos)
        actioned = true
      when "f"
        @board.switch_flag(@start_pos)
        actioned = true
      when "0"
        save_file
      else
        exit
      end
    end
  end
  
  
  def user_prompt
    #return array of coordinates
      puts "Flag/Reveal/Save Game? (F/R/S)"
      f_r = gets.chomp.upcase
      while !["F", "R", "S"].include?(f_r)
        puts "invalid input, Flag/Reveal/Save Game? (F/R/S)"
        f_r = gets.chomp.upcase
      end
      
      if f_r == "S"
        save_file
      else
        puts "which column?"
        col = ALPHABET.index(gets.chomp.upcase)
        puts "which row?"
        row = gets.chomp.to_i
        [f_r, [row, col]]
      end
  end
  
  def action(input)
    if input.first == "R"
      @board.reveal_tile(input.last)
    else
      @board.switch_flag(input.last)
    end
  end
  
  
  
  private
  
  def valid_pos?(pos)
    row, col = pos
    row.between?(0, @board.height - 1) && col.between?(0, @board.width - 1)
  end
  
  def move_cursor(input)
    case input 
    when "w"
      new_pos = [@start_pos.first - 1,@start_pos.last]
    when "a"
      new_pos = [@start_pos.first,@start_pos.last - 1]
    when "s"
      new_pos = [@start_pos.first + 1,@start_pos.last]   
    when "d"
      new_pos = [@start_pos.first,@start_pos.last + 1]
    end
    update_cursor(new_pos) if valid_pos?(new_pos) 
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Welcome to Minesweeper"
  puts "How many rows would you like? (1 - 26)"
  rows = gets.chomp.to_i
  puts "How many columns would you like? (1 - 26)"
  cols = gets.chomp.to_i
  puts "How many bombs would you like?"
  bombs_n = gets.chomp.to_i
  g = Game.new(rows, cols, bombs_n)
  g.start_game
end