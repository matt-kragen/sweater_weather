class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: ImageSerializer.new(BackgroundFacade.get_background(params[:location]))
  end
end
