require 'spec_helper'

describe GoogleGeocodings::Client do
  let(:api_key) { "api_key" }
  let(:client) { GoogleGeocodings::Client.new(api_key) }

  it 'should initialize with an api_key' do
    expect(client.api_key).to eq(api_key)
  end
  describe "::geocode" do
    let(:address) { "address" }
    it "should request geocode" do
      expect(GoogleGeocodings::Geocoding).to receive(:geocode).with(api_key, address, {})
      client.geocode(address)
    end
  end
end
