# frozen_string_literal: true

require_relative '../data_source'
require_relative './exchange'
require_relative './application_service'

class SailingCost < ApplicationService
  def initialize(sailing)
    @sailing = sailing
  end

  def call
    # saillings will be an array
    # check all the sailings will be how much
    DataSource.rates.filter_map do |rate|
      if rate['sailing_code'] == @sailing['sailing_code']
        @sailing['euro_rate'] = Exchange.call(rate['rate'].to_f, rate['rate_currency'],
                                              @sailing['departure_date'])
        @sailing['rate'] = rate['rate']
        @sailing['rate_currency'] = rate['rate_currency']
      end
    end
  end
end
