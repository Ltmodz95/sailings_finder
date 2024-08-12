# frozen_string_literal: true

require_relative 'application_service'
require 'date'
require_relative '../graph/graph_utils'
require_relative 'sailing_cost'

class Fastest < ApplicationService
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
        SailingCost.call(sailing)
        sailing if shipment.include? sailing['sailing_code']
      end
      sailings << legs
    end

    sailings.min_by { |elm| Date.parse(elm.last['arrival_date']) }
  end
end
