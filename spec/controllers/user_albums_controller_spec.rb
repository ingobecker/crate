require 'spec_helper'

describe UserAlbumsController do

  before do
    @user = FactoryGirl.create :user
    sign_in @user
  end
  it { should route(:get, '/my_albums').to(action: :index)}

  it 'requires all nested parameters' do
    %w(artist_attributes tracks_attributes).each do |k|
      p = ActionController::Parameters.new album: {k => {}}
      expect{UserAlbumsController::AlbumParams.permit p}.to raise_error(ActionController::ParameterMissing)
    end
  end

  it 'permits parameters' do
    
    h = { album: {
            name: 'foo',
            cover: 'foo',
            artist_attributes: {
              name: 'foo',
            },
            tracks_attributes: {
              '0' => {
                name: 'foo',
                duration_str: '02:03',
              },
              '1' => {
                name: 'bar',
                duration_str: '02:03',
              }
            }
          }
        }
      
    p = ActionController::Parameters.new(h)

    expect(UserAlbumsController::AlbumParams.permit(p).with_indifferent_access).to eq(h.with_indifferent_access)
  end

  describe 'GET index' do
    before do
      get :index
    end

    it{ should respond_with(:success) }
    it{ should render_template(:index) }
    it{ should render_with_layout(:application) }
  end

  describe 'GET new' do
    render_views
    before do
      get :new
    end

    it{ should respond_with(:success) }
    it{ should render_template(:new) }
    it{ should render_template(partial: '_form') }
    it{ should render_with_layout(:application) }
  end

  describe 'POST create' do
    before do
      a = FactoryGirl.attributes_for :album
      post :create, album: {name: 'baz',
                            cover: fixture_file_upload('files/cover.jpg', 'image/jpeg'),
                            artist_attributes: {name: 'foo'},
                            tracks_attributes: {'0' => {name: 'bar', duration_str: '00:23'}}}
    end

    it{ should redirect_to(user_albums_path) }
    it{ should set_the_flash }
  end
end
