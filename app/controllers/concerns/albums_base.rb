module AlbumsBase
  extend ActiveSupport::Concern

  included do
    defaults resource_class: Album, collection_name: 'albums', instance_name: 'album'
    respond_to :html
  end

  def index
    @user_album_ids = current_user.try :album_ids
    index!
  end

  def collection
    end_of_association_chain.includes(:artist)
  end
end
