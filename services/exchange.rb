# frozen_string_literal: true

require_relative '../data_source'
require_relative './application_service'

class Exchange < ApplicationService
  def initialize(rate, currency, departure_date)
    @rate = rate
    @currency = currency.downcase
    @departure_date = departure_date
  end

  def call
    return @rate if @currency == 'eur'

    forex = DataSource.exchange_rates.filter do |exchange_rate|
      exchange_rate[@departure_date] unless exchange_rate[@departure_date].nil?
    end
    (@rate / forex[@departure_date][@currency]).round(2)
  end
end
