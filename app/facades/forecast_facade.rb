class ForecastFacade
  def self.get_forecast(location)
    Forecast.new(ForecastService.call_forecast(location))
  end
end
