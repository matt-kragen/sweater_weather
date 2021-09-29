class Api::V1::BackgroundsController < ApplicationController
  def index
    if !params[:location].present? || params[:location].nil?
      render(json: ErrorSerializer.missing_location, status: :bad_request)
    elsif params.keys.size > 3
      render(json: ErrorSerializer.invalid_params, status: :bad_request)
    else
      render json: ImageSerializer.new(BackgroundFacade.get_background(params[:location]))
    end
  end
end
