class Api::V1::BookSearchController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity]
    coords = GeocodeFacade.retrieve_geocode(location)

    render json: BookQuerySerializer.new(BookFacade.get_books(location, quantity, coords))
  end
end