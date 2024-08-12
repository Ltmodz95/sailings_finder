# frozen_string_literal: true

class GraphNode
  attr_accessor :adj_list, :value

  def initialize(value)
    @value = value
    @adj_list = []
  end
end
