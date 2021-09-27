require 'rails_helper'

RSpec.describe "Background service" do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = BackgroundService.conn('https://api.pexels.com/v1/search')
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe 'class methods' do
    it '::call_background', :vcr do
      params = { location: 'denver' }
      background_response = BackgroundService.call_background(params[:location])

      expect(background_response).to be_a(Hash)
      expect(background_response).to have_key(:per_page)
      
      expect(background_response[:per_page]).to be_a(Numeric) 
      expect(background_response).to have_key(:total_results)
      
      expect(background_response[:total_results]).to be_a(Numeric) 
      expect(background_response).to have_key(:photos)
      
      expect(background_response[:photos]).to be_an(Array) 
      expect(background_response[:photos][0]).to be_a(Hash)
      
      expect(background_response[:photos][0]).to have_key(:url)
      expect(background_response[:photos][0][:url]).to be_a(String) 
      
      expect(background_response[:photos][0]).to have_key(:photographer)
      expect(background_response[:photos][0][:photographer]).to be_a(String) 
      
      expect(background_response[:photos][0]).to have_key(:photographer_url)
      expect(background_response[:photos][0][:photographer_url]).to be_a(String) 
      
      expect(background_response[:photos][0]).to have_key(:src)
      expect(background_response[:photos][0][:src]).to be_a(Hash) 
      expect(background_response[:photos][0][:src].keys).to eq(
        [
          :original,
          :large2x,
          :large,
          :medium,
          :small,
          :portrait,
          :landscape,
          :tiny
        ]
      )
    end
  end
end