class BookService < BaseService
  def self.call_books(location, quantity)
    response = conn("http://openlibrary.org/search.json").get do |req|
      req.params[:q] = location
      req.params[:limit] = quantity
    end
    parse(response)
  end
end