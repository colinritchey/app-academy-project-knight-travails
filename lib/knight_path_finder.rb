require_relative '00_tree_node.rb'

class KnightPathFinder
  DELTA = [
    [1, 2],
    [-1, 2],
    [2, 1],
    [1, -2],
    [-1, -2],
    [-2, 1],
    [-2, -1],
    [2,-1]
  ]
  def initialize(initial_pos = [0,0])
    @pos = initial_pos
    @move_tree = build_move_tree
    @visited_positions = [initial_pos]
  end

  def build_move_tree
    root = PolyTreeNode.new(@pos)

    root
  end

  def new_move_positions(pos)
    moves = valid_moves(pos)
    moves.reject! {|move| @visited_positions.include?(move)}
    moves
  end

  def valid_moves(pos)
    moves = DELTA.map { |change| [pos[0] + change[0], pos[1] + change[1]]}
    moves.select {|move| move[0].between?(0, 7) && move[1].between?(0, 7)}
  end

  def find_path
  end
end
