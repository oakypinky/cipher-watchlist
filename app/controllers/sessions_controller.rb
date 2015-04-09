class SessionsController < ApplicationController
  skip_before_filter :verify_auth_token, only: :create

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:auth_token] = user.auth_token
      session[:user_id] = user.id
    else
      user = User.create(user_params)
      if user
        user.create_token!
        session[:auth_token] = user.auth_token
        session[:user_id] = user.id
      end
    end

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
