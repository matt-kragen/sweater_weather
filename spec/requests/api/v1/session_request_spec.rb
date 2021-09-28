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
      xit 'displays 401 error if password incorrect' do
        user_params = {
          email: 'test@test.com',
          password: 'fhtagn',
          password_confirmation: 'fhtagn'
        }
        user = User.create(user_params)

        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        params = {
          "email": user.email.to_s,
          "password": 'fhtag'
        }

        post api_v1_sessions_path, headers: headers, params: params.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        expect(response.body).to eq
      end
    end
  end
end
