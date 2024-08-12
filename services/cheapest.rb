# frozen_string_literal: true

require_relative 'application_service'
require_relative './sailing_cost'
require_relative '../graph/graph_utils'

class Cheapest < ApplicationService
  include GraphUtils

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @shipments = []
  end

  def call
    find_all_shipments_between_two_ports
  end

  private

  def find_all_shipments_between_two_ports
    path = []
    dfs_search(SailingsGraph.nodes[@origin].adj_list, path)

    sailings = []
    @shipments.map do |shipment|
      legs = DataSource.sailings.filter do |sailing|
        sailing if shipment.include? sailing['sailing_code']
      end
      sailings << legs
    end

    sailings.each do |sailing|
      sum = 0
      sailing.each do |leg|
        SailingCost.call(leg)
        sum += leg['euro_rate']
        leg.delete('euro_rate')
      end

      sailing << sum
    end

    sailings.min_by(&:last)[0..-2] # removing the acummlated sum
  end
end
