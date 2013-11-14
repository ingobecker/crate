require 'spec_helper'

describe AlbumsController do

  it { should route(:get, '/albums').to(action: :index)}
  it { should route(:get, '/albums/23').to(action: :show, id: 23)}

  describe 'GET index' do
    before do
      get :index
    end

    it{ should respond_with(:success) }
    it{ should render_template(:index) }
    it{ should render_with_layout(:application) }
  end

  describe 'GET show' do
    before do
      @artist = FactoryGirl.create :artist
      @album = FactoryGirl.create :album_with_tracks, tracks_count: 23, artist: @artist
      xhr :get, :show, id: @album.id
    end

    it{ should respond_with(:success) }
    it{ should render_template(:show) }
    it{ should_not render_with_layout(:application) }
  end
end
