class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if request.headers[:CONTENT_TYPE] != "application/json"
      render json: ErrorSerializer.bad_format, status: :unsupported_media_type
    elsif user.valid?
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.invalid_credentials, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
