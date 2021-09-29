require 'rails_helper'

describe 'Road Trip requests' do
  describe 'Road trip creation' do
    let!(:user) { create(:user) }

    describe 'happy path' do
      it 'can create road trip and return JSON response', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO',
          "api_key": 'thisisyourapikey'
        }
        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response[:data]).to be_a(Hash)
        expect(parsed_response[:data].keys).to eq(%i[id type attributes])

        expect(parsed_response[:data][:type]).to eq('road_trip')
        expect(parsed_response[:data][:id]).to be_a(String)
        expect(parsed_response[:data][:attributes]).to be_a(Hash)
      end
    end

    describe 'sad path' do
      it 'displays 401 error if bad API key given', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO',
          "api_key": 'incorrectapikey'
        }

        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        expect(response.body.include?('Invalid API Key')).to eq(true)
      end

      it 'displays 401 error if no API key given', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO'
        }

        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        expect(response.body.include?('Invalid API Key')).to eq(true)
      end

      it 'throws 415 error if no JSON body is sent', :vcr do
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO',
          "api_key": 'thisisyourapikey'
        }

        post api_v1_road_trip_index_path, params: params

        expect(response).to_not be_successful
        expect(response.status).to eq(415)
        message = 'Payload must be JSON format'
        expect(response.body.include?(message)).to eq(true)
      end

      it 'returns travel time as "impossible route" if route is not traversible by car', :vcr do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver, CO',
          "destination": 'Johannesburg, South Africa',
          "api_key": 'thisisyourapikey'
        }
        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response[:data]).to be_a(Hash)
        expect(parsed_response[:data].keys).to eq(%i[id type attributes])

        expect(parsed_response[:data][:attributes][:travel_time]).to eq('Impossible route')
        expect(parsed_response[:data][:attributes][:weather_at_eta]).to eq(nil)
      end
    end
  end
end
