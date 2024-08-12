require_relative '../test_helper'
require_relative '../../services/sailing_cost'

RSpec.describe Exchange do
  before do
    DataSource.reader(JsonReader.new('shipping_data.json'))
  end

  it 'exchanges the value from aa currency to euros' do
    expect(Exchange.call(589.30, 'USD', '2022-02-01')).to eql 523.36
  end
end
