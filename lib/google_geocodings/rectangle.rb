module GoogleGeocodings
  class Rectangle
    attr_reader :format
    # @param bounds [Hash]
    #   @bounds start_latitude [Float]
    #   @bounds start_longitude [Float]
    #   @bounds end_latitude [Float]
    #   @bounds end_longitude [Float]
    def initialize(bounds = {})
      bounds ||= {}
      start_latitude  = bounds[:start_latitude]
      start_longitude = bounds[:start_longitude]
      end_latitude    = bounds[:end_latitude]
      end_longitude   = bounds[:end_longitude]
      return unless start_latitude && start_longitude && end_latitude && end_longitude
      @format = [[("%.8f" % start_latitude), ("%.8f" % start_longitude)].join(','), [("%.8f" % end_latitude), ("%.8f" % end_longitude)].join(',')].join('|')
    end
  end
end
