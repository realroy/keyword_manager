require 'rails_helper'

describe 'User sign in', type: :feature do
  let(:user) { create(:user) }

  context 'without valid account' do
    it 'should show error message' do
      visit root_path
      within('#new_user') do
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'caplin'
      end

      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end
  end

  context 'with valid account' do
    before do
      login_as(user)
    end

    it 'should navigate to keyword list page' do
      visit root_path

      expect(page).to have_content('Keywords')
    end
  end
end
