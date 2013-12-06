class AlbumsController < AbstractAlbumsController

  inherit_resources
  include AlbumsBase
  actions :index

  def show
    if request.xhr?
      render :show, layout: false
    else
      head :bad_request
    end
  end
end
