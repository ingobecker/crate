require 'spec_helper'

describe UserAlbumsController do

  it { should route(:get, '/my_albums').to(action: :index)}

  describe 'GET index' do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
      get :index
    end

    it{ should respond_with(:success) }
    it{ should render_template(:index) }
    it{ should render_with_layout(:application) }
  end
end
