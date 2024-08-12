# frozen_string_literal: true

require_relative './application_service'
require_relative './sailing_cost'

class CheapestDirect < ApplicationService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def call
    direct_sailings.map do |sailing|
      SailingCost.call(sailing)
    end
    cheapest_direct = (direct_sailings.sort_by { |sail| sail['euro_rate'] }).first
    cheapest_direct.delete('euro_rate')
    cheapest_direct
  end

  private

  def direct_sailings
    res = []
    DataSource.sailings.each do |sailing|
      res.push(sailing) if sailing['origin_port'] == @origin && sailing['destination_port'] == @destination
    end
    res
  end
end
