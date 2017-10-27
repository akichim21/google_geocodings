module GoogleGeocodings
  # Thrown when a request was denied by the server
  #
  # This can be the case when:
  # - API key is not authorized for the Geocodings API
  # - querying the SPOT_LIST_URL <b>without</b> the following parameters:
  # - - key
  class RequestDeniedError < HTTParty::ResponseError
    def to_s
      response.parsed_response['error_message']
    end
  end
end
