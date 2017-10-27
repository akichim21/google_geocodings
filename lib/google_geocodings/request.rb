module GoogleGeocodings
  class Request
    attr_reader :response, :options
    include ::HTTParty
    default_options.update(verify: false)
    format :json

    GEOCODE_URL = "https://maps.googleapis.com/maps/api/geocode/json".freeze

    def self.geocode(options = {})
      request = new(GEOCODE_URL, options)
      request.parsed_response
    end

    def parsed_response
      return @response.headers["location"] if @response.code >= 300 && @response.code < 400
      case @response.parsed_response['status']
      when 'OK', 'ZERO_RESULTS'
        @response.parsed_response
      when 'OVER_QUERY_LIMIT'
        raise OverQueryLimitError.new(@response)
      when 'REQUEST_DENIED'
        raise RequestDeniedError.new(@response)
      when 'INVALID_REQUEST'
        raise InvalidRequestError.new(@response)
      when 'UNKNOWN_ERROR'
        raise UnknownError.new(@response)
      when 'NOT_FOUND'
        raise NotFoundError.new(@response)
      end
    end

    def initialize(url, options, follow_redirects = true)
      @response = self.class.get(url, query: options, follow_redirects: follow_redirects)
    end
  end
end
