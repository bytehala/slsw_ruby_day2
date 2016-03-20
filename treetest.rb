class Tree
  attr_accessor :children, :node_name

  def initialize(name, children=[])
    @children = children
    @node_name = name
  end

  def visit_all(&block)
    visit &block
    children.each {|child| child.visit_all &block}
  end

  def visit(&block)
    block.call self
  end

  def to_s
    node_name
  end
end

ruby_tree = Tree.new("Ruby", [Tree.new("Reia"), Tree.new("MacRuby")])

puts 'Visiting a node'
ruby_tree.visit {|node| puts node.node_name}

puts 'Visiting all'
ruby_tree.visit_all {|node| puts node.node_name}
