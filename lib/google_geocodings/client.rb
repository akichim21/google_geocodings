module GoogleGeocodings
  class Client
    # @return [String] the provided api key
    attr_reader :api_key

    # Creates a new Client instance which proxies the requests to the certain classes
    #
    # @param [String] api_key The api key to use for the requests
    def initialize(api_key = @api_key)
      @api_key = api_key
    end

    # geocode
    #
    # @return [Array<Geocoding>]
    # @param [String] address
    # @param [Hash] options
    #   @option bounds [Hash]
    #     @bounds start_latitude [Float]
    #     @bounds start_longitude [Float]
    #     @bounds end_latitude [Float]
    #     @bounds end_longitude [Float]
    #   @option language [String]
    #   @option region [String]
    # see: https://developers.google.com/maps/documentation/geocoding/intro#geocoding
    # NOTE: Not yet correspond to components param
    def geocode(address, options = {})
      language   = options.delete(:language)
      region     = options.delete(:region)
      rectangle  = Rectangle.new(options.delete(:bounds))

      options = {
        key: api_key,
        address: address,
        language: language,
        region: region,
        bounds: rectangle.format,
      }
      request(:geocode, options)
    end

    # reverse geocode
    #
    # @return [Array<Geocoding>]
    # @param [String] address
    # @param [Hash] options
    #   @option bounds [Hash]
    #     @bounds start_latitude [Float]
    #     @bounds start_longitude [Float]
    #     @bounds end_latitude [Float]
    #     @bounds end_longitude [Float]
    #   @option language [String]
    #   @option region [String]
    # see: https://developers.google.com/maps/documentation/geocoding/intro#ReverseGeocoding
    # NOTE: Not yet correspond to components param
    def reverse_geocode(latitude, longitude, options = {})
      language   = options.delete(:language)
      region     = options.delete(:region)
      rectangle  = Rectangle.new(options.delete(:bounds))

      options = {
        key: api_key,
        latlng: Location.new(latitude, longitude).format,
        language: language,
        region: region,
        bounds: rectangle.format,
      }
      request(:geocode, options)
    end

    private
    def request(method, options)
      results = []

      response = Request.send(method, options)
      response['results'].each do |result|
        results << Geocoding.new(result, api_key)
      end

      results
    end
  end
end
