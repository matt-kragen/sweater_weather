require 'rails_helper'

RSpec.describe Forecast do
  describe 'instance creation' do
    it 'exists and has attributes' do
      json = File.read('./spec/fixtures/json_fixtures/denver_forecast.json')
      parsed_json = JSON.parse(json, symbolize_names: true)
      forecast = Forecast.new(parsed_json)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather[:datetime]).to be_a(String)
      expect(forecast.current_weather[:sunrise]).to be_a(String)
      expect(forecast.current_weather[:sunset]).to be_a(String)
      expect(forecast.current_weather[:temp]).to be_a(Float)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)
      expect(forecast.current_weather[:humidity]).to be_an(Integer)
      expect(forecast.current_weather[:uvi]).to be_a(Float)
      expect(forecast.current_weather[:visibility]).to be_an(Integer)
      expect(forecast.current_weather[:conditions]).to be_a(String)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather[0][:date]).to be_a(String)
      expect(forecast.daily_weather[0][:sunrise]).to be_a(String)
      expect(forecast.daily_weather[0][:sunset]).to be_a(String)
      expect(forecast.daily_weather[0][:max_temp]).to be_a(Float)
      expect(forecast.daily_weather[0][:min_temp]).to be_a(Float)
      expect(forecast.daily_weather[0][:conditions]).to be_a(String)
      expect(forecast.daily_weather[0][:icon]).to be_a(String)

      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather[0][:time]).to be_a(String)
      expect(forecast.hourly_weather[0][:temp]).to be_a(Float)
      expect(forecast.hourly_weather[0][:conditions]).to be_a(String)
      expect(forecast.hourly_weather[0][:icon]).to be_a(String)
    end
  end
end
