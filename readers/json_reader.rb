# frozen_string_literal: true

require 'json'
require_relative 'reader'
# a class to read json files
class JsonReader < Reader
  def initialize(file_name)
    @file_name = file_name
  end

  def read
    data = File.read(@file_name)
    JSON.parse(data)
  end
end
