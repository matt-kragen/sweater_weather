class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
               .try(:authenticate, params[:password])

    if user
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: :ok
    else
      render status: :unauthorized
    end
  end
end
