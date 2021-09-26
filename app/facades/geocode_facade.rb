class GeocodeFacade
  def self.retrieve_geocode(location)
    geocode = GeocodeService.call_geocode(location)
    Location.new(geocode)
  end
end