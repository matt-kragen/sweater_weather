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
      location = GeocodeFacade.retrieve_geocode(params[:location])
      forecast_response = ForecastService.call_forecast(location)

      expect(forecast_response).to be_a Hash
      expect(forecast_response.keys).to eq(%i[
                                             lat
                                             lon
                                             timezone
                                             timezone_offset
                                             current
                                             hourly
                                             daily
                                           ])

      expect(forecast_response[:lat]).to be_a Numeric
      expect(forecast_response[:lon]).to be_a Numeric

      expect(forecast_response[:current]).to be_a Hash
      expect(forecast_response[:daily]).to be_an Array
      expect(forecast_response[:hourly]).to be_an Array

      expect(forecast_response[:current].keys).to eq(%i[
                                                       dt
                                                       sunrise
                                                       sunset
                                                       temp
                                                       feels_like
                                                       pressure
                                                       humidity
                                                       dew_point
                                                       uvi
                                                       clouds
                                                       visibility
                                                       wind_speed
                                                       wind_deg
                                                       wind_gust
                                                       weather
                                                     ])

      expect(forecast_response[:daily][0]).to be_a Hash
      expect(forecast_response[:daily][0].keys).to eq(%i[
                                                        dt
                                                        sunrise
                                                        sunset
                                                        moonrise
                                                        moonset
                                                        moon_phase
                                                        temp
                                                        feels_like
                                                        pressure
                                                        humidity
                                                        dew_point
                                                        wind_speed
                                                        wind_deg
                                                        wind_gust
                                                        weather
                                                        clouds
                                                        pop
                                                        uvi
                                                      ])

      expect(forecast_response[:hourly][0]).to be_a Hash
      expect(forecast_response[:hourly][0].keys).to eq(%i[
                                                         dt
                                                         temp
                                                         feels_like
                                                         pressure
                                                         humidity
                                                         dew_point
                                                         uvi
                                                         clouds
                                                         visibility
                                                         wind_speed
                                                         wind_deg
                                                         wind_gust
                                                         weather
                                                         pop
                                                       ])
    end
  end
end
