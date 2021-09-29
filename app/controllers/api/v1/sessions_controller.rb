class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
               .try(:authenticate, params[:password])

    if request.headers[:CONTENT_TYPE] != "application/json"
      render json: ErrorSerializer.bad_format, status: :unsupported_media_type
    elsif user
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: :ok
    else
      render json: ErrorSerializer.invalid_credentials, status: :unauthorized
    end
  end
end
