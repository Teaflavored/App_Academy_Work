require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    winning_moves_list = []
    tying_moves_list = []

    new_node = TicTacToeNode.new(game.board, mark)

    new_node.children.each do |child|
      return child.prev_move_pos if child.winning_node? mark
    end

    new_node.children.each_with_index do |child, idx|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end
    raise "fuck"
  end

end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
