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
    end

    describe 'as xhr' do
      before do
        xhr :get, :show, id: @album.id
      end

      it{ should respond_with(:success) }
      it{ should render_template(:show_body) }
      it{ should_not render_with_layout(:application) }
    end

    describe 'without xhr' do
      before do
        get :show, id: @album.id
      end

      it{ should respond_with(:success) }
      it{ should render_template(:show) }
      it{ should render_with_layout(:application) }
    end

  end

  describe 'GET search' do
    before do
      Album.tire.create_elasticsearch_index
      @user = FactoryGirl.create :user
      @artist = FactoryGirl.create :artist
      @album = FactoryGirl.create :album_with_tracks, tracks_count: 23, artist: @artist
      Album.tire.index.refresh
      sign_in @user
    end

    after do
      Album.tire.index.delete
    end

    describe 'user albums' do
      before do
        @album.users << @user
        xhr :get, :search, q: @album.name[0...2], scope: 'true'
      end

      it{ should respond_with(:success) }
      it 'should respond without results' do
        expect(response.body).to eql('[]')
      end
    end

    describe 'all albums' do
      before do
        xhr :get, :search, q: @album.name[0...2], scope: 'false'
      end

      it{ should respond_with(:success) }
      it 'should respond with results' do
        expect(response.body).not_to eql('[]')
      end
    end
  end
end
