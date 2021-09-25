require 'rails_helper'

RSpec.describe 'Weather API' do
  it 'retrieves weather report based on city', :vcr do
    get '/api/v1/forecast', params: {location: 'denver,co'}
    expect(response).to be_successful

    report = JSON.parse(response.body, symbolize_names: true)[:data]
    
  #   expect(report).to have_key(:id)
  #   expect(report[:id].class).to eq(String)
  #   expect(report[:attributes]).to have_key(:current_temp)
  #   expect(report[:attributes][:current_temp].class).to eq(Float)
  #   expect(report[:attributes]).to have_key(:current_conditions)
  #   expect(report[:attributes][:current_conditions].class).to eq(String)
  #   expect(report[:attributes]).to have_key(:forecast)
  #   expect(report[:attributes][:forecast].class).to eq(Array)
  #   expect(report[:attributes][:forecast].count).to eq(2)
  #   expect(report[:attributes][:forecast][0]).to have_key(:date)
  #   expect(report[:attributes][:forecast][0][:date].class).to eq(String)
  #   expect(report[:attributes][:forecast][0]).to have_key(:max_temp)
  #   expect(report[:attributes][:forecast][0][:max_temp].class).to eq(Float)
  #   expect(report[:attributes][:forecast][0]).to have_key(:min_temp)
  #   expect(report[:attributes][:forecast][0][:min_temp].class).to eq(Float)
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
