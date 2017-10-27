require 'spec_helper'

describe GoogleGeocodings::Request do
  let(:api_key) { "api_key" }

  describe "::request" do
    context "success" do
      let(:address) { "北海道帯広市東3条南2-1" }
      let(:language) { "ja" }
      before do
        stub_request(:get, GoogleGeocodings::Request::GEOCODE_URL).with(query: { address: address, key: api_key, language: language })
        .to_return(
          status: 200,
          headers: { 'Content-Type' =>  'application/json' },
          body: File.read("#{GoogleGeocodings.root}/spec/fixtures/geocode_success.json")
        )
      end
      it "should request" do
        response = GoogleGeocodings::Request.geocode({ address: address, key: api_key, language: language })
        expect(response['results'].size).to eq 1
        response['results'].map do |result|
          expect(result.key?("address_components")).to be_truthy
          expect(result.key?("formatted_address")).to be_truthy
          expect(result.key?("geometry")).to be_truthy
          expect(result.key?("place_id")).to be_truthy
          expect(result.key?("types")).to be_truthy
        end
      end
    end

    context 'without address' do
      it do
        expect do
          GoogleGeocodings::Request.geocode({ key: api_key, language: 'ja' })
        end.to raise_error GoogleGeocodings::InvalidRequestError
      end
    end
  end
end
