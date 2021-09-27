require 'rails_helper'

RSpec.describe "Books API" do
  describe 'happy path' do
    it 'returns a list of books for given destination', :vcr do
      get api_v1_book_search_path, params: { location: 'denver, co', quantity: 15 }

      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      books = JSON.parse(response.body, symbolize_names: true)

      expect(books).to be_a(Hash)
      
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)
    end
  end
end