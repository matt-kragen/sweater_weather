require 'rails_helper'

RSpec.describe BookQuery do
  describe 'instance creation' do
    it 'exists and has attributes' do
      json1 = File.read('./spec/fixtures/json_fixtures/book_query.json')
      json2 = File.read('./spec/fixtures/json_fixtures/denver_forecast.json')
      parsed_json1 = JSON.parse(json1, symbolize_names: true)
      parsed_json2 = JSON.parse(json2, symbolize_names: true)
      book = BookQuery.new(parsed_json1, parsed_json2)

      expect(book).to be_a(BookQuery)
      expect(book.destination).to be_a(String)
      expect(book.forecast).to be_a(Hash)
      expect(book.forecast[:summary]).to be_a(String)
      expect(book.forecast[:temperature]).to be_a(Numeric)
      expect(book.total_books_found).to be_a(Numeric)
      expect(book.books).to be_an(Array)
      expect(book.books[0]).to be_a(Hash)
      expect(book.books[0][:isbn]).to be_an(Array)
      expect(book.books[0][:isbn][0]).to be_a(String)
      expect(book.books[0][:title]).to be_a(String)
      expect(book.books[0][:publisher]).to be_an(Array)
      expect(book.books[0][:publisher][0]).to be_a(String)
    end
  end
end