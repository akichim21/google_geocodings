module GoogleGeocodings
  # Thrown when a request was rejected as invalid by the server
  #
  # This can be the case when:
  # - querying the SPOT_LIST_URL <b>without</b> the following parameters:
  # - - location
  # - - radius
  class InvalidRequestError < HTTParty::ResponseError
  end
end
