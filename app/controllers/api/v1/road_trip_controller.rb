class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    if request.headers[:CONTENT_TYPE] != "application/json"
      render json: ErrorSerializer.bad_format, status: :unsupported_media_type
    else
      render json: RoadTripSerializer.new(
        RoadTripFacade.get_route(road_trip_params)
      ), status: :created
    end
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def authenticate_api_key
    current_user = User.find_by(api_key: params[:api_key])
    if !current_user
      render json: ErrorSerializer.invalid_api_key, status: :unauthorized
    end
  end
end
