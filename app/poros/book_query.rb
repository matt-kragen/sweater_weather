class BookQuery
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(book_data, weather_data)
    @destination = weather_data
    @forecast = {
      summary: weather_data,
      temperature: weather_data
    }
    @total_books_found = book_data
    @books = book_data
  end
end