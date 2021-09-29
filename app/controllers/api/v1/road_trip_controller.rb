class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    render json: RoadTripSerializer.new(
      RoadTripFacade.get_route(road_trip_params)
    ), status: :created
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def authenticate_api_key
    current_user = User.find_by(api_key: params[:api_key])
    if !current_user
      render json: { errors: ['Invalid API Key'] }, status: :unauthorized
    end
  end
end
