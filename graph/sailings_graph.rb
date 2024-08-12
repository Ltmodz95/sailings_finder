# frozen_string_literal: true

require_relative 'graph_node'

class SailingsGraph
  attr_accessor :nodes

  class << self
    def build_graph(data)
      data.each do |sailing|
        add_node(sailing['origin_port'])
        add_node(sailing['destination_port'])
        add_edge(sailing['origin_port'], sailing['destination_port'], sailing['sailing_code'])
      end
    end

    def nodes
      @nodes ||= {}
    end

    def add_node(value)
      nodes[value] ||= GraphNode.new(value)
    end

    def add_edge(from, to, sailing_code)
      nodes[from].adj_list << { to: nodes[to], sailing_code: sailing_code }
    end
  end
end
