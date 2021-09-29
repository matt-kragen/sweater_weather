require 'rails_helper'

describe 'Session requests' do
  describe 'Session creation' do
    describe 'happy path' do
      it 'successfully creates session and displays appropriate response' do
        user_params = {
          email: 'test@test.com',
          password: 'fhtagn',
          password_confirmation: 'fhtagn'
        }
        User.create(user_params)

        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "email": 'test@test.com',
          "password": 'fhtagn'
        }
        post api_v1_sessions_path, headers: headers, params: params.to_json

        expect(response).to be_successful
        expect(response.status).to eq(200)
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to be_a(Hash)
        expect(parsed_response).to have_key(:data)
        expect(parsed_response[:data]).to be_a(Hash)

        expect(parsed_response[:data].keys).to eq(%i[id type attributes])
        expect(parsed_response[:data][:id]).to be_a(String)
        expect(parsed_response[:data][:type]).to eq('user')
        expect(parsed_response[:data][:attributes]).to be_a(Hash)

        expect(parsed_response[:data][:attributes].keys).to eq(%i[email api_key])
        expect(parsed_response[:data][:attributes][:email]).to be_a(String)
        expect(parsed_response[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'fails to create user if no JSON body is sent' do
        params = {
          "email": 'test@test.com',
          "password": 'fhtagn'
        }

        post api_v1_sessions_path, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(415)
        message = 'Payload must be JSON format'
        expect(response.body.include?(message)).to eq(true)
      end

      it 'fails to login without email' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = { "password": 'fhtagn' }

        post api_v1_sessions_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        message = 'Those credentials are invalid'
        expect(response.body.include?(message)).to eq(true)
      end

      it 'fails to login without password' do
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = { "email": 'test@test.com' }

        post api_v1_sessions_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        message = 'Those credentials are invalid'
        expect(response.body.include?(message)).to eq(true)
      end
    end
  end
end
