require 'rails_helper'

describe 'User requests' do
  describe 'happy path' do
    it 'can create user and return JSON response' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      params = {
        "email": 'test@test.com',
        "password": 'fhtagn',
        "password_confirmation": 'fhtagn'
      }
      expect(User.count).to eq(0)

      post api_v1_users_path, headers: headers, params: params.to_json

      expect(response).to be_successful
      expect(response.status).to eq(201)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to be_a(Hash)
      expect(parsed_response[:data]).to be_a(Hash)
      expect(parsed_response[:data].keys).to eq(%i[id type attributes])

      expect(parsed_response[:data][:type]).to eq('user')
      expect(parsed_response[:data][:id]).to be_a(String)
      expect(parsed_response[:data][:attributes]).to be_a(Hash)

      expect(parsed_response[:data][:attributes].keys).to eq(%i[email api_key])
      expect(parsed_response[:data][:attributes][:email]).to eq('test@test.com')
      expect(parsed_response[:data][:attributes][:api_key]).to be_a(String)

      expect(User.count).to eq(1)
    end
  end

  describe 'sad path' do
    it 'fails to create user without email' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      params = {
        "password": 'fhtagn',
        "password_confirmation": 'fhtagn'
      }
      
      post api_v1_users_path, headers: headers, params: params.to_json
      expect(User.count).to eq(0)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      message = "Those credentials are invalid"
      expect(response.body.include?(message)).to eq(true)
    end
    
    it 'fails to create user without password' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      params = {
        "email": "test@test.com",
      }
      
      post api_v1_users_path, headers: headers, params: params.to_json
      expect(User.count).to eq(0)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      message = "Those credentials are invalid"
      expect(response.body.include?(message)).to eq(true)
    end
    
    it 'fails to create user if password confirmation fails' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      params = {
        "email": "test@test.com",
        "password": 'fhtagn',
        "password_confirmation": 'ngathf'
      }
      
      post api_v1_users_path, headers: headers, params: params.to_json
      expect(User.count).to eq(0)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      message = "Those credentials are invalid"
      expect(response.body.include?(message)).to eq(true)
    end
    
    it 'fails to create user if no JSON body is sent' do
      params = {
        "email": "test@test.com",
        "password": 'fhtagn',
        "password_confirmation": 'fhtagn'
      }
      
      post api_v1_users_path, params: params.to_json
      expect(User.count).to eq(0)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(415)
      message = "Payload must be JSON format"
      expect(response.body.include?(message)).to eq(true)
    end
  end
end
