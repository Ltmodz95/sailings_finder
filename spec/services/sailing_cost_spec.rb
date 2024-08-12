require_relative '../test_helper'
require_relative '../../services/sailing_cost'

RSpec.describe SailingCost do
  before do
    DataSource.reader(JsonReader.new('shipping_data.json'))
  end

  let(:expected_result) do
    {
      'origin_port' => 'CNSHA',
      'destination_port' => 'NLRTM',
      'departure_date' => '2022-02-01',
      'arrival_date' => '2022-03-01',
      'sailing_code' => 'ABCD',
      'rate' => '589.30',
      'euro_rate' => 523.36,
      'rate_currency' => 'USD'
    }
  end

  it 'gets the ship cost in euros' do
    sailing = DataSource.sailings[0]
    SailingCost.call(sailing)
    expect(sailing).to eql expected_result
  end
end
