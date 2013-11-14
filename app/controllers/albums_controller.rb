class AlbumsController < ApplicationController
  inherit_resources
  actions :index
  respond_to :html

  def show
    if request.xhr?
      render :show, layout: false
    else
      head :bad_request
    end
  end
end
