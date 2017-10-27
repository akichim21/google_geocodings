module GoogleGeocodings
  class Geocoding
    attr_reader :address_components, :formatted_address, :geometry, :place_id, :types, :api_key
    def initialize(json_result_object, api_key)
      @address_components = json_result_object['address_components']
      @formatted_address  = json_result_object['formatted_address']
      @geometry           = json_result_object['geometry']
      @place_id           = json_result_object['place_id']
      @types              = json_result_object['types']
      @api_key            = api_key
    end

    def [] (key)
      send(key)
    end

    def self.geocode(api_key, address, options = {})
      language  = options.delete(:language)
      region    = options.delete(:region)
      bounds    = options.delete(:bounds)

      options = {
        key: api_key,
        address: address,
        language: language,
        region: region,
        bounds: bounds
      }
      self.request(:geocode, options)
    end

    def self.request(method, options)
      results = []

      response = Request.send(method, options)
      response['results'].each do |result|
        results << self.new(result, options[:key])
      end

      results
    end
  end
end
