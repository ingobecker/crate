require 'spec_helper'

feature 'The Homepage' do
  scenario 'should show login-form form' do
    visit root_path
    page.should have_content('Login into your crate')
    page.should have_content('Create your own crate')
  end
end
