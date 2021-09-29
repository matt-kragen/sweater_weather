class RoadTripFacade
  def self.get_route(locations)
    coords = GeocodeFacade.retrieve_geocode(locations[:destination])
    route = RoadTripService.call_route(locations)
    forecast = ForecastService.call_forecast(coords)
    trip = RoadTrip.new(locations, route, forecast)
  end
end
