require 'rails_helper'

describe 'User sign up', type: :feature do
  let(:user) { create(:user) }

  context 'with invalid information' do
    before { visit new_user_registration_path }

    it 'should show error message' do
      within('#new_user') do
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: '1'
        fill_in 'Password confirmation', with: '2'
      end

      click_button 'Sign up'

      expect(page).to have_content('errors prohibited this user from being saved')
    end
  end

  context 'with valid information' do
    before { visit new_user_registration_path }

    it 'should show error message' do
      within('#new_user') do
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: '123456789'
        fill_in 'Password confirmation', with: '123456789'
      end

      click_button 'Sign up'

      expect(page).to have_content('You have signed up successfully')
    end
  end
end
