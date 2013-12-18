class AlbumsController < AbstractAlbumsController

  inherit_resources
  include AlbumsBase
  actions :index

  def show
    if request.xhr?
      render :show_body, layout: false
    else
      render :show
    end
  end

  def search
    options = {q: params[:q]}
    options[:user] = current_user if params[:scope] == 'true'

    s = Album.search options
    render json: s
  end
end
