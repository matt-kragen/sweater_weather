require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'forecast creation' do
    it 'creates Forecast object', :vcr do
      location = GeocodeFacade.retrieve_geocode('denver,co')
      forecast = ForecastFacade.get_forecast(location)
      expect(forecast).to be_a(Forecast)
    end
  end
end
