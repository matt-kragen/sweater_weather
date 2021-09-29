class Api::V1::ForecastController < ApplicationController
  def index
    if !params[:location].present? || params[:location].nil?
      render(json: ErrorSerializer.missing_location, status: :bad_request)
    elsif params.keys.size > 3
      render(json: ErrorSerializer.invalid_params, status: :bad_request)
    else
      location = GeocodeFacade.retrieve_geocode(params[:location])
      render json: ForecastSerializer.new(ForecastFacade.get_forecast(location))
    end
  end
end
