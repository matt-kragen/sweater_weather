require 'rails_helper'

RSpec.describe 'Background requests' do
  describe 'happy path' do
    it 'returns a background image for given city', :vcr do
      get api_v1_backgrounds_path params: { location: 'denver' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      background = JSON.parse(response.body, symbolize_names: true)

      expect(background).to be_a(Hash)

      expect(background).to have_key(:data)
      expect(background[:data]).to be_a(Hash)

      expect(background[:data].keys).to eq(
        %i[
          id
          type
          attributes
        ]
      )
      expect(background[:data][:id]).to eq('null')
      expect(background[:data][:type]).to eq('image')

      expect(background[:data][:attributes]).to be_a(Hash)
      expect(background[:data][:attributes].keys).to eq(
        %i[
          url
          images
          credits
        ]
      )

      expect(background[:data][:attributes][:url]).to be_a(String)
      expect(background[:data][:attributes][:images]).to be_a(Hash)
      expect(background[:data][:attributes][:images].count).to eq(8)
      expect(background[:data][:attributes][:credits]).to be_a(Hash)
      expect(background[:data][:attributes][:credits].size).to eq(3)
    end
  end

  describe 'sad path' do
    it 'throws an error if params not included', :vcr do
      get api_v1_backgrounds_path
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = "Location must be present"
      expect(response.body.include?(message)).to eq(true)
    end

    it 'throws an error if params blank', :vcr do
      get api_v1_backgrounds_path, params: {location: '' }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = "Location must be present"
      expect(response.body.include?(message)).to eq(true)
    end

    it 'throws an error if extra information is passed', :vcr do
      get api_v1_backgrounds_path, params: { location: 'denver,co', days: 5 }
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      message = "Only location will be accepted"
      expect(response.body.include?(message)).to eq(true)
    end
  end
end
