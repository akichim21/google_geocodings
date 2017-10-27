module GoogleGeocodings
  class Client
    # @return [String] the provided api key
    attr_reader :api_key

    def initialize(api_key = @api_key)
      @api_key = api_key
    end

    def geocode(address, options = {})
      Geocoding.geocode(api_key, address, options)
    end
  end
end
