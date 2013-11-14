class HomeController < ApplicationController
  def index
    redirect_to albums_path if user_signed_in?
  end
end
