require 'spec_helper'

feature 'The Homepage' do
  scenario 'should show login-form form' do
    visit root_path
    page.should have_content('Login into your crate')
    page.should have_content('Create your own crate')
    page.should have_link('Sign up', href: new_user_registration_path)
  end
end
