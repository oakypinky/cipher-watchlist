class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :verify_auth_token
  before_filter :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    else
      @current_user = nil
    end
  end

  def verify_auth_token
    unless @current_user && @current_user.authenticate_with_token(session[:auth_token])
      redirect_to root_path
    end
  end
end
