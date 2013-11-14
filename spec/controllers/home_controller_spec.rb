require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    before do
      get 'index'
    end
    it{ should respond_with(:success) }
    it{ should render_template(:index) }
    it{ should render_with_layout(:application) }
  end

end
