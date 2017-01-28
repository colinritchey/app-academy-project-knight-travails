require 'byebug'

class PolyTreeNode
  attr_reader :value, :children, :parent

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent == nil
    node.children << self unless node.nil?
    @parent = node
  end

  def add_child(node)
    return if node == nil
    node.parent = self
  end

  def remove_child(node)
    raise "Error: node not a child or nil" unless node && @children.include?(node)
    @children.delete(node)
    node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    result = nil

    @children.each do |child|
      result = child.dfs(target_value)
      break if result
    end

    result
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      cur_node = queue.shift
      return cur_node if cur_node.value == target_value
      queue += cur_node.children
    end

    nil
  end

end
