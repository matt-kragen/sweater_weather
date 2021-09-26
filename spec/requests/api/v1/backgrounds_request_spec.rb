require 'rails_helper'

RSpec.describe "Background API" do
  describe 'happy path' do
    it 'returns a background image for given city' do
      get api_v1_backgrounds_index_path, params: {location: 'denver,co'}

      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      background = JSON.parse(response.body, symbolize_names: true)
    end
  end

  # describe 'sad path' do
  #   it '' do
  
  #   end
  # end
end