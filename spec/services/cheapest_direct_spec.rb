require_relative '../test_helper'
require_relative '../../services/cheapest_direct'

RSpec.describe CheapestDirect do
  before do
    DataSource.reader(JsonReader.new('shipping_data.json'))
    SailingsGraph.build_graph(DataSource.sailings)
  end

  let(:expected_result) do
    { 'origin_port' => 'CNSHA', 'destination_port' => 'NLRTM', 'departure_date' => '2022-01-30',
      'arrival_date' => '2022-03-05', 'sailing_code' => 'MNOP', 'rate' => '456.78', 'rate_currency' => 'USD' }
  end

  it 'returns the cheapest direct sailings' do
    expect(CheapestDirect.call('CNSHA', 'NLRTM')).to eql expected_result
  end
end
