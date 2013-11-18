require 'spec_helper'

feature 'Albums page without albums' do
  scenario 'show' do
    visit albums_path
    page.should have_content('No albums found.')
  end
end

feature 'Albums page with existing album', js: true do
  background do
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 2, artist: @artist
  end

  scenario 'show' do
    visit albums_path
    page.should have_content('(2 Tracks)')
    page.should_not have_content('.panel-heading a.btn')
  end

  scenario 'click on album' do
    visit albums_path
    page.should_not have_content('No albums found.')
    find('.panel-heading a[data-toggle=collapse]').click
    page.should have_css('ol')
  end
end

feature 'Albums page with existing album and user signed in', js: true do
  background do
    @user = FactoryGirl.create :user
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 2, artist: @artist
    sign_in_and_visit @user, albums_path
  end

  scenario 'mouse over button' do
    find('.panel-heading a.btn').trigger(:mouseover)
    find('.tooltip').visible?
  end

  scenario 'click on the plus-button of the album' do
    find('.panel-heading a.btn').click
    sleep 1
    visit user_albums_path
    page.should have_content('(2 Tracks)')
  end

  scenario 'click on the minus-button of the album' do
    find('.panel-heading a.btn').click
    sleep 1
    visit user_albums_path
    page.should have_content('(2 Tracks)')
    visit albums_path
    find('.panel-heading a.btn').click
    sleep 1
    visit user_albums_path
    page.should have_content('No albums found.')

  end

end
