require 'rails_helper'

describe 'Road Trip requests' do
  describe 'Road trip creation' do
    describe 'happy path' do
      it 'can create road trip and return JSON response' do
        user_params = {
          email: 'test@test.com',
          password: 'fhtagn',
          password_confirmation: 'fhtagn'
        }
        user = User.create(user_params)

        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO',
          "api_key": user.api_key.to_s
        }
        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response[:data]).to be_a(Hash)
        expect(parsed_response[:data].keys).to eq(%i[id type attributes])

        expect(parsed_response[:data][:type]).to eq('roadtrip')
        expect(parsed_response[:data][:id]).to be_a(String)
        expect(parsed_response[:data][:attributes]).to be_a(Hash)
      end
    end

    describe 'sad path' do
      xit 'displays 401 error if no API key given' do
        user_params = {
          email: 'test@test.com',
          password: 'fhtagn',
          password_confirmation: 'fhtagn'
        }
        user = User.create(user_params)

        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "origin": 'Denver,CO',
          "destination": 'Pueblo,CO',
          "api_key": 'incorrectapikey'
        }

        post api_v1_road_trip_index_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        expect(response.body).to eq
      end
    end
  end
end
