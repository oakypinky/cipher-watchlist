class WelcomeController < ApplicationController
  skip_before_filter :verify_auth_token, only: :index

  def index
  end
end
