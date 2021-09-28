class Api::V1::RoadTripController < ApplicationController
  def create
    render status: :created
  end
end