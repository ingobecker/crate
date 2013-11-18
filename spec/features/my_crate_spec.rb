require 'spec_helper'

feature 'Browse my crate with nothing added' do
  background do
    @user = FactoryGirl.create :user
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 2, artist: @artist
    sign_in_and_visit @user, user_albums_path
  end

  scenario 'show' do
    page.should have_content('No albums found.')
  end
end

feature 'Browse my crate with albums', js: true do
  background do
    @user = FactoryGirl.create :user
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 2, artist: @artist
    @user.albums << @album

    sign_in_and_visit @user, user_albums_path
  end

  scenario 'click on minus button of a album' do
    page.should have_content(@album.name)
    find('.panel-heading a.btn').click
    page.should have_no_css('.panel-heading')
    visit user_albums_path
    page.should have_content('No albums found.')
  end
end

