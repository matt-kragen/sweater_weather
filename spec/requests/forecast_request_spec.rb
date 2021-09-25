require 'rails_helper'

RSpec.describe 'Weather API' do
  it 'retrieves weather report based on city' do
    get api_v1_forecast_index_path, params: {location: 'denver,co'}
    expect(response).to be_successful
    expect(response.status).to eq(204)

    report = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(report).to be_a Hash
    expect(report).to have_key :data
    expect(report[:data]).to be_a Hash
    
    expect(report[:data]).to have_key :id
    expect(report[:data][:id]).to eq('null')
    
    expect(report[:data]).to have_key :type
    expect(report[:data][:type]).to eq('forecast')
    
    expect(report[:data]).to have_key :attributes
    expect(report[:data][:attributes]).to be_a Hash
    expect(report[:data][:attributes]).to have_key :current_weather
    expect(report[:data][:attributes]).to have_key :daily_weather
    expect(report[:data][:attributes]).to have_key :hourly_weather
    
  end

  # it 'sad path: params do not include location or days', :vcr do
  #   get '/api/v1/forecast'
  #   expect(response).to_not be_successful
  #   expect(response.status).to eq(400)
  # end

  # it 'edge case: params are included but in correct format', :vcr do
  #   get '/api/v1/forecast', params: {location: '', days: ''}
  #   expect(response).to_not be_successful
  #   expect(response.status).to eq(400)
  # end
end
