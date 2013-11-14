require 'spec_helper'

feature 'The navbar' do
  scenario 'should show login and signup links' do
    visit root_path
    within('ul.nav.navbar-nav.navbar-right') do
      page.should have_link('Login')
      page.should have_link('Signup')
    end
  end
end

feature 'The navbar for signed in user' do
  background do
    @user = FactoryGirl.create :user
  end
  scenario 'should show logout link when signed in' do

    visit root_path
    within 'form.user' do
      page.fill_in 'Email', with: @user.email
      page.fill_in 'Password', with: 'foobarbaz'
      page.click_button 'Sign in'
    end

    within('ul.nav.navbar-nav.navbar-right') do
      page.should have_link 'Logout'
    end

  end
end
