require 'rails_helper'

RSpec.describe ForecastService do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = ForecastService.conn('https://api.openweathermap.org/data/2.5/onecall')
      expect(connection).to be_an_instance_of(Faraday::Connection)
    end
  end

  describe 'class methods' do
    it '::call_forecast', :vcr do
      params = { location: 'denver,co' }
      location = GeocodeFacade.retrive_geocode(params[:location])
      forecast_response = ForecastService.call_forecast(location)
    end
  end
end
