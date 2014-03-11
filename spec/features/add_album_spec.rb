require 'spec_helper'

feature 'Add album form', js: true do
  background do
    @user = FactoryGirl.create :user
    sign_in_and_visit @user, new_user_album_path
  end

  scenario 'show' do
    within('form#new_album') do
      page.should have_field 'Artist name'
      page.should have_field 'Album name'
      page.should have_field 'Track name'
      page.should have_field 'Duration'
      page.should have_field 'Cover'
    end
  end

  scenario 'add one more track' do
    within('form#new_album') do
      fill_in 'Track name', with: 'foo'
      fill_in 'Duration', with: '23'
      find_button('Add another track').click

      all('.tracks input')[-2..-1].each do |input|
        input.should have_content('')
      end

      expect(all('.tracks input'))
      expect(page.all('.tracks input.name').count).to be(2)
    end
  end

  scenario 'add one more track and create' do
    within('form#new_album') do
      find_button('Add another track').click
      fill_in 'Album name', with: 'Album'
      fill_in 'Artist name', with: 'Artist'

      all('.tracks input.duration_str').each do |input|
        input.set('23:42')
      end

      all('.tracks input.name').each do |input|
        input.set('foo')
      end
      find_button('Create Album').click
      expect(URI.parse(current_url).request_uri).to eq(user_albums_path)

    end
  end

end
