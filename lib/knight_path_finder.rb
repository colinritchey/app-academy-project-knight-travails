require_relative '00_tree_node.rb'

class KnightPathFinder
  attr_reader :move_tree, :visited_positions

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
    @initial_pos = initial_pos
    @visited_positions = [initial_pos]
    @move_tree = build_move_tree
  end

  def build_move_tree
    root = PolyTreeNode.new(@initial_pos)
    queue = [root]

    until queue.empty?
      current_node = queue.shift

      @visited_positions << current_node.value
      possible_moves = new_move_positions(current_node.value)

      possible_moves.each do |pos|
        new_move_node = PolyTreeNode.new(pos)
        new_move_node.parent = current_node
        queue << new_move_node
      end
    end

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

  def find_path(end_pos)
    found_node = @move_tree.dfs(end_pos)
    trace_path_back(found_node)
  end

  def trace_path_back(node)
    result = [node.value]
    current_node = node

    until current_node.parent.nil?
      current_node = current_node.parent
      result << current_node.value
    end

    result.reverse
  end

end
