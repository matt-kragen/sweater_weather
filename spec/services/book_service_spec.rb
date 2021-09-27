require 'rails_helper'

RSpec.describe "Book service" do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = BookService.conn('http://openlibrary.org/search.json')
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe 'class methods' do
    describe '::call_books' do
      it 'returns books for a given location and quantity', :vcr do
        params = { location: 'denver,co', quantity: 15 }
        response = BookService.call_books(params[:location], params[:quantity])

        expect(response).to be_a Hash

        expect(response).to have_key(:numFound)
        expect(response[:numFound]).to be_an(Integer)
        
        expect(response).to have_key(:docs)
        expect(response[:docs]).to be_an(Array)
        expect(response[:docs].size).to eq(15)
        
        # Individual book
        json = File.read('./spec/fixtures/json_fixtures/book_response.json')
        parsed_json = JSON.parse(json, symbolize_names: true)
        expect(response[:docs][0]).to eq(parsed_json)
      end
    end
  end
end