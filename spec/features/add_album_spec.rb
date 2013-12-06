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

  scenario 'add one more track' do
    within('form#new_album') do
      fill_in 'Track name', with: 'foo'
      find_button('Create Album').click

      expect(all('.tracks div.form-group').last[:class]).to include('has-error')
      find_button('Add another track').click

      expect(page.all('.tracks input.name').count).to be(2)
      expect(all('.tracks div.form-group').last[:class]).not_to include('has-error')

      all('.tracks input')[-2..-1].each do |input|
        input.should have_content('')
      end

    end
  end


end
