require 'spec_helper'

describe GoogleGeocodings::Client do
  let(:api_key) { "api_key" }
  let(:client) { GoogleGeocodings::Client.new(api_key) }

  it 'should initialize with an api_key' do
    expect(client.api_key).to eq(api_key)
  end
  describe "::geocode" do
    let(:address) { "address" }
    let(:language) { 'ja' }
    before do
      stub_request(:get, GoogleGeocodings::Request::GEOCODE_URL).with(query: { address: address, key: api_key, language: language, region: "", bounds: "" })
      .to_return(
        status: 200,
        headers: { 'Content-Type' =>  'application/json' },
        body: File.read("#{GoogleGeocodings.root}/spec/fixtures/geocode_success.json")
      )
    end
    it "should request geocode" do
      collection = client.geocode(address, language: language)
      expect(collection.map(&:class).uniq).to eq [GoogleGeocodings::Geocoding]
    end
  end
  describe "::reverse_geocode" do
    let(:latitude) { "34.172684" }
    let(:longitude) { "73.961452" }
    let(:language) { 'ja' }
    before do
      stub_request(:get, GoogleGeocodings::Request::GEOCODE_URL).with(query: { latlng: "#{"%.8f" % latitude},#{"%.8f" % longitude}", key: api_key, language: language, region: "", bounds: "" })
      .to_return(
        status: 200,
        headers: { 'Content-Type' =>  'application/json' },
        body: File.read("#{GoogleGeocodings.root}/spec/fixtures/geocode_success.json")
      )
    end
    it "should request geocode" do
      collection = client.reverse_geocode(latitude, longitude, language: language)
      expect(collection.map(&:class).uniq).to eq [GoogleGeocodings::Geocoding]
    end
  end
end
