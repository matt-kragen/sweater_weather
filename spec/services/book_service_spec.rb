require 'rails_helper'

RSpec.describe "Book service" do
  describe 'connection' do
    it 'can make a connection to external service' do
      connection = BookService.conn('http://openlibrary.org/search.json')
      expect(connection).to be_a(Faraday::Connection)
    end
  end
end