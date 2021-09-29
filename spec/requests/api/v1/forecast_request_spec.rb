require 'rails_helper'

RSpec.describe 'Forecast requests' do
  describe 'happy path' do
    it 'retrieves weather report based on city', :vcr do
      get api_v1_forecast_index_path, params: { location: 'denver,co' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      report = JSON.parse(response.body, symbolize_names: true)
      expect(report).to be_a(Hash)

      expect(report).to have_key(:data)
      expect(report[:data]).to be_a(Hash)

      expect(report[:data].keys).to eq(
        %i[
          id
          type
          attributes
        ]
      )
      expect(report[:data][:id]).to eq('null')
      expect(report[:data][:type]).to eq('forecast')

      expect(report[:data][:attributes]).to be_a(Hash)
      expect(report[:data][:attributes].keys).to eq(
        %i[
          current_weather
          daily_weather
          hourly_weather
        ]
      )

      # Current Weather
      expect(report[:data][:attributes][:current_weather].keys).to eq(%i[
                                                                        datetime
                                                                        sunrise
                                                                        sunset
                                                                        temp
                                                                        feels_like
                                                                        humidity
                                                                        uvi
                                                                        visibility
                                                                        conditions
                                                                        icon
                                                                      ])
      expect(report[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(report[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(report[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(report[:data][:attributes][:current_weather][:temp]).to be_a(Numeric)
      expect(report[:data][:attributes][:current_weather][:feels_like]).to be_a(Numeric)
      expect(report[:data][:attributes][:current_weather][:humidity]).to be_a(Numeric)
      expect(report[:data][:attributes][:current_weather][:uvi]).to be_a(Numeric)
      expect(report[:data][:attributes][:current_weather][:visibility]).to be_a(Numeric)
      expect(report[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(report[:data][:attributes][:current_weather][:icon]).to be_a(String)

      # Daily Weather
      expect(report[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(report[:data][:attributes][:daily_weather].size).to eq(5)
      expect(report[:data][:attributes][:daily_weather][0]).to be_a(Hash)

      expect(report[:data][:attributes][:daily_weather][0].keys).to eq(
        %i[
          date
          sunrise
          sunset
          max_temp
          min_temp
          conditions
          icon
        ]
      )
      expect(report[:data][:attributes][:daily_weather][0][:date]).to be_a(String)
      expect(report[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
      expect(report[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
      expect(report[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Numeric)
      expect(report[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Numeric)
      expect(report[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
      expect(report[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)

      # Hourly Weather
      expect(report[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(report[:data][:attributes][:hourly_weather].size).to eq(8)
      expect(report[:data][:attributes][:hourly_weather][0]).to be_a(Hash)

      expect(report[:data][:attributes][:hourly_weather][0].keys).to eq(
        %i[
          time
          temp
          conditions
          icon
        ]
      )
      expect(report[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
      expect(report[:data][:attributes][:hourly_weather][0][:temp]).to be_a(Numeric)
      expect(report[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
      expect(report[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'throws an error if params not included', :vcr do
      get api_v1_forecast_index_path
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = 'Location must be present'
      expect(response.body.include?(message)).to eq(true)
    end

    it 'throws an error if params blank', :vcr do
      get api_v1_forecast_index_path, params: { location: '' }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = 'Location must be present'
      expect(response.body.include?(message)).to eq(true)
    end

    it 'throws an error if extra information is passed', :vcr do
      get api_v1_forecast_index_path, params: { location: 'denver,co', days: 5 }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = 'Only location will be accepted'
      expect(response.body.include?(message)).to eq(true)
    end
  end
end
