require 'rails_helper'

RSpec.describe "Books API" do
  describe 'happy path' do
    it 'returns a list of books for given destination', :vcr do
      params = { location: 'denver, co', quantity: 15 }
      get api_v1_book_search_index_path(params)

      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      books = JSON.parse(response.body, symbolize_names: true)

      expect(books).to be_a(Hash)
      
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)

      expect(books[:data].keys).to eq(
        [
          :id,
          :type,
          :attributes
        ]
      )
      expect(books[:data][:id]).to eq('null')
      expect(books[:data][:type]).to eq('book_query')
      
      expect(books[:data][:attributes]).to be_a(Hash)
      
      expect(books[:data][:attributes]).to have_key(:destination)
      expect(books[:data][:attributes][:destination]).to be_a(String)
      
      expect(books[:data][:attributes]).to have_key(:forecast)
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)
      
      expect(books[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)
      expect(books[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(books[:data][:attributes][:forecast][:temperature]).to be_a(Numeric)

      expect(books[:data][:attributes]).to have_key(:total_books_found)
      expect(books[:data][:attributes][:total_books_found]).to be_an(Integer)
      
      expect(books[:data][:attributes]).to have_key(:books)
      expect(books[:data][:attributes][:books]).to be_an(Array)

      expect(books[:data][:attributes][:books][0]).to be_a(Hash)
      expect(books[:data][:attributes][:books][0].keys).to eq([:isbn, :title, :publisher])
      expect(books[:data][:attributes][:books][0][:isbn]).to be_an(Array)
      expect(books[:data][:attributes][:books][0][:isbn][0]).to be_a(String)
      expect(books[:data][:attributes][:books][0][:title]).to be_a(String)
      expect(books[:data][:attributes][:books][0][:publisher]).to be_an(Array)
      expect(books[:data][:attributes][:books][0][:publisher][0]).to be_a(String)
    end
  end
end