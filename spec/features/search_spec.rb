require 'spec_helper'

feature 'The Layout' do
  scenario 'without being signed in' do
    visit root_path
    expect(page).to have_css('nav form input[name=nav-search]')
    expect(page).not_to have_css('nav form input[type=checkbox]')
  end
end

feature 'The Layout' do
  before do
    @user = FactoryGirl.create :user
  end

  scenario 'being signed in' do
    sign_in_and_visit @user, root_path
    expect(page).to have_css('nav form input[name=nav-search]')
    expect(page).to have_css('nav form input[type=checkbox]')
  end
end

feature 'The search field', js: true do
  before do
    Album.tire.index.delete
    Album.tire.create_elasticsearch_index
    @artist = FactoryGirl.create :artist
    @album = FactoryGirl.create :album_with_tracks, tracks_count: 2, artist: @artist
    Album.tire.index.refresh
  end

  scenario 'filled in with existing album' do
    visit root_path
    find('.search-select').click
    within '.search-select-dropdown' do
      find(:css, 'input').set @album.name[0...2]
    end
    content = "#{@album.name} by #{@artist.name}"
    expect(page).to have_content(content)
    all('div', text: content).first.click
    expect(URI.parse(current_url).path).to eq(album_path(@album))
  end
end
