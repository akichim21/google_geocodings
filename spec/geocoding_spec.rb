require 'spec_helper'

describe GoogleGeocodings::Geocoding do
  let(:api_key) { "api_key" }

  describe "::geocode" do
    context "success" do
      before do
        stub_request(:any, %r{#{GoogleGeocodings::Request::GEOCODE_URL}.*}).to_return(
          status: 200,
          headers: { 'Content-Type' =>  'application/json' },
          body: File.read("#{GoogleGeocodings.root}/spec/fixtures/geocode_success.json")
        )
      end
      let(:address) { "北海道帯広市東3条南2-1" }
      it do
        collection = described_class.geocode(api_key, address, language: 'ja')
        expect(collection.map(&:class).uniq).to eq [GoogleGeocodings::Geocoding]
        collection.map do |geocoding|
          expect(geocoding.address_components.is_a?(Array)).to be_truthy
          expect(geocoding.formatted_address.is_a?(String)).to be_truthy
          expect(geocoding.geometry.is_a?(Hash)).to be_truthy
          expect(geocoding.place_id.is_a?(String)).to be_truthy
          expect(geocoding.types.is_a?(Array)).to be_truthy
        end
      end
    end
  end
end
