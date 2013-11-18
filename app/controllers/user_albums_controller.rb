class UserAlbumsController < AlbumsController
  before_filter :authenticate_user!
  defaults resource_class: Album, collection_name: 'albums'

  def add
    if request.xhr?
      current_user.albums << resource
      head :ok
    else
      head :bad_request
    end
  end

  def remove
    if request.xhr?
      current_user.albums.destroy resource
      head :ok
    else
      head :bad_request
    end
  end

  protected
  def begin_of_association_chain
    current_user unless ['add', 'remove'].include? action_name
  end
end
