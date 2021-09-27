require 'rails_helper'

RSpec.describe BookFacade do
  describe 'book creation' do
    it 'creates Book objects', :vcr do
      location = "denver,co"
      coords = GeocodeFacade.retrieve_geocode(location)
      forecast = ForecastFacade.get_forecast(coords)

      quantity = 1
      
      book_query = BookFacade.get_books(location, quantity, coords)
      require 'pry'; binding.pry
      expect(book_query).to be_a(BookQuery)
    end
  end
end