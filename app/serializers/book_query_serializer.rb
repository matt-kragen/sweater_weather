class BookQuerySerializer
  include FastJsonapi::ObjectSerializer
  set_id { 'null' }
  attributes :destination, :forecast, :total_books_found

  attributes :books do |object|
    object.books
  end
end