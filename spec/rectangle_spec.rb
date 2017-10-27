require 'spec_helper'

describe GoogleGeocodings::Rectangle do
  it "shoud return nil when param nil" do
    expect(described_class.new.format).to eq nil
  end
  it 'should return two lat/lng pairs separated by a "|" based on SW and NE lat/lng bounds' do
    expect(described_class.new({ start_latitude: '123', start_longitude: '456', end_latitude: '321', end_longitude: '654' }).format).to eq('123.00000000,456.00000000|321.00000000,654.00000000')
  end
end
