class BookQuery
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(book_data, weather_data)
    @destination = book_data[:q]
    @forecast = {
      summary: weather_data[:current][:weather][0][:main],
      temperature: weather_data[:current][:temp]
    }
    @total_books_found = book_data[:numFound]
    @book_list = book_data[:docs]
  end

  def books
    @book_list.map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
end