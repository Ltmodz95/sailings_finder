# frozen_string_literal: true

# this class will hold the ways we retrieve the data
class DataSource
  class << self
    def reader(reader)
      @reader ||= reader
    end

    def sailings
      @sailings ||= @reader.read['sailings']
    end

    def rates
      @rates ||= @reader.read['rates']
    end

    def exchange_rates
      @exchange_rates ||= @reader.read['exchange_rates']
    end
  end
end
