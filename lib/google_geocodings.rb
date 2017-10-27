require "google_geocodings/version"
require 'httparty'

%w(client geocoding invalid_request_error not_found_error over_query_limit_error request_denied_error request unknown_error).each do |file|
  require File.join(File.dirname(__FILE__), 'google_geocodings', file)
end

module GoogleGeocodings
  class << self
    attr_accessor :api_key

    def root
      File.dirname __dir__
    end

    def configuration
      yield self
    end
  end
end
