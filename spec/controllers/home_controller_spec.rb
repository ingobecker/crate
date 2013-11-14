require 'spec_helper'

describe HomeController do

  it { should route(:get, '/').to(action: :index) }

  describe "GET 'index'" do
    before do
      get 'index'
    end
    it{ should respond_with(:success) }
    it{ should render_template(:index) }
    it{ should render_with_layout(:application) }
  end

  describe 'GET index while signed in' do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
      get :index
    end

    it { should redirect_to(albums_path)}
  end

end
