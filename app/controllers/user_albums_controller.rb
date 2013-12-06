class UserAlbumsController < AbstractAlbumsController

  before_filter :authenticate_user!
  inherit_resources
  include AlbumsBase
  actions :new, :create, :edit, :update, :index
  respond_to :html

  def build_resource
    @album ||= super
    @album.tracks.build if @album.tracks.empty?
    @album.build_artist if @album.artist.nil?
    @album.users << current_user if @album.new_record?
    @album
  end

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

  class AlbumParams
    def self.permit params
      p = {album: params.fetch(:album, {}).permit(:name, artist_attributes: :name, tracks_attributes: [:name, :duration_str])}
      album = p[:album]
      if album.any?
        album.merge artist_attributes: album.fetch(:artist_attributes).permit(:name)
        album.merge tracks_attributes: album.fetch(:tracks_attributes).permit(:name, :duration_str)
      end
      p[:album] = album
      p
    end
  end

  protected

  def begin_of_association_chain
    current_user unless ['add', 'remove'].include? action_name
  end

  def permitted_params
    AlbumParams.permit params
  end

end
