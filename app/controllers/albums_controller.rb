class AlbumsController < ApplicationController
  inherit_resources
  actions :index
  respond_to :html

  def index
    @user_album_ids = current_user.try :album_ids
    index!
  end

  def collection
    end_of_association_chain.includes(:artist)
  end

  def show
    if request.xhr?
      render :show, layout: false
    else
      head :bad_request
    end
  end
end
