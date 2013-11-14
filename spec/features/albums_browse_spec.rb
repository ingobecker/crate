require 'spec_helper'

feature 'Browse albums without existing album' do
  scenario 'should show now albums' do
    visit albums_path
    page.should have_content('No albums found.')
  end
end

feature 'Browse albums with existing albums' do
  background do
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 23, artist: @artist
  end

  scenario 'should show album' do
    visit albums_path
    page.should have_content('(23 Tracks)')
  end
end

feature 'Click on Album', js: true do
  background do
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 23, artist: @artist
  end

  scenario 'should show tracks of the album' do
    visit albums_path
    page.should_not have_content('No albums found.')
    find('.panel-heading a').click
    page.should have_css('ol')
  end
end
