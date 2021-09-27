class BookFacade
  def self.get_books(location, quantity, coords)
    BookQuery.new(BookService.call_books(location, quantity), ForecastService.call_forecast(coords))
  end
end
