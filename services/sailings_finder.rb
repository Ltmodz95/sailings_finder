# frozen_string_literal: true

require './services/cheapest_direct'
require './services/cheapest'
require './services/fastest'

class SailingsFinder < ApplicationService
  def initialize(origin, destination, service)
    @klass = Object.const_get(service.split('-').map(&:capitalize).join)
    @origin = origin
    @destination = destination
  end

  def call
    return 'We are currently not supporting this origin port' unless SailingsGraph.nodes[@origin]
    return 'We are currently not supporting this destination port' unless SailingsGraph.nodes[@destination]

    @klass.call(@origin, @destination)
  end
end
