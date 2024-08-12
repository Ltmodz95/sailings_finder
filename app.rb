# frozen_string_literal: true

require './data_source'
require './readers/json_reader'
require_relative './graph/sailings_graph'
require_relative './services/sailings_finder'

class App
  def initialize
    DataSource.reader(JsonReader.new('shipping_data.json'))
    SailingsGraph.build_graph(DataSource.sailings) # setup the graph
    run
  end

  def run
    loop do
      puts 'please enter the origin port, destination port and search criteria:'
      origin_port = gets.strip.chomp
      destination_port = gets.strip.chomp
      service = gets.strip.chomp

      puts "\n"
      puts 'Results:'
      puts "\n"
      p SailingsFinder.call(origin_port, destination_port, service)
      puts "\n"
      puts 'Type CTRL+C  to quit'
    end
  end
end

App.new # fires up the application
