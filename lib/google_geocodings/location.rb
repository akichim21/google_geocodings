module GoogleGeocodings
  class Location
    attr_reader :format
    def initialize(latitude, longitude)
      @format = [("%.8f" % latitude), ("%.8f" % longitude)].join(',')
    end
  end
end
