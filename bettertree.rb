require 'pry'
class Tree
  attr_accessor :children, :node_name

  def initialize(treestruct = {})
    puts "---start---"
    @children = {}
    @node_name = "c #{treestruct.keys[0]}"
    puts "treestruct.values #{treestruct.values}"

    treestruct.values[0].each do |k,v|
      puts "#{k}, kids #{v}"
      #what i was doing, storing name here,
      #but it was actually the name of the child
      #@node_name = @node_name +  "#{k}"

      #another mistake was already passing the children's children
      @children[k] = Tree.new({k => v})
    end

    #end
    puts "node_name: #{@node_name } - children: #{@children}"
    puts "----end---"
  end

  def visit_all(&block)
    visit &block
    if @children != {}
      @children.each {|k, child| child.visit_all &block}
    end
  end

  def visit(&block)
    block.call self
  end

  def to_s
    "#{node_name}, #{children}"
  end

end

input = {'grandpa' => {'dad' => {'lowell' => {}, 'lem' => {}}
                      }
        }
        #input = {'grandpa' => { 'dad'   => {'lowell' => {}, 'lem' => {}},
        #                        'uncle' => {'glenn' => {}, 'sandra' => {}}
        #                      }
        #        }
ruby_tree = Tree.new(input)

puts 'Visiting a node'
x = ruby_tree.visit {|node| puts node.node_name}
puts "tree: #{ruby_tree}"
puts

puts 'Visiting all'
ruby_tree.visit_all {|node| puts node.node_name}
