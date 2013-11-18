module Features
  module SessionHelpers
    def sign_in_and_visit(user, path)

        visit root_path

        within 'form.user' do
          page.fill_in 'Email', with: @user.email
          page.fill_in 'Password', with: 'foobarbaz'
          page.click_button 'Sign in'
        end

        visit path
    end
  end
end
