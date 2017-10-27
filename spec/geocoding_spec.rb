require 'spec_helper'

describe GoogleGeocodings::Geocoding do
  describe "attribute" do
    it do
      result = JSON.parse(File.read("#{GoogleGeocodings.root}/spec/fixtures/geocode_success.json"))['results'].first
      geocoding = described_class.new(result, "api_key")
      expect(geocoding.address_components.is_a?(Array)).to be_truthy
      expect(geocoding.formatted_address.is_a?(String)).to be_truthy
      expect(geocoding.geometry.is_a?(Hash)).to be_truthy
      expect(geocoding.place_id.is_a?(String)).to be_truthy
      expect(geocoding.types.is_a?(Array)).to be_truthy
    end
  end
end
