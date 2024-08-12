require_relative '../test_helper'
require_relative '../../services/cheapest'

RSpec.describe Cheapest do
  before do
    DataSource.reader(JsonReader.new('shipping_data.json'))
    SailingsGraph.build_graph(DataSource.sailings)
  end

  let(:expected_result) do
    [{ 'origin_port' => 'CNSHA', 'destination_port' => 'ESBCN', 'departure_date' => '2022-01-29',
       'arrival_date' => '2022-02-12', 'sailing_code' => 'ERXQ', 'rate' => '261.96', 'rate_currency' => 'EUR' },
     { 'origin_port' => 'ESBCN', 'destination_port' => 'NLRTM', 'departure_date' => '2022-02-16',
       'arrival_date' => '2022-02-20', 'sailing_code' => 'ETRG', 'rate' => '69.96', 'rate_currency' => 'USD' }]
  end

  it 'returns the cheapest sailing either direct or indirect' do
    expect(Cheapest.call('CNSHA', 'NLRTM')).to eql expected_result
  end
end
