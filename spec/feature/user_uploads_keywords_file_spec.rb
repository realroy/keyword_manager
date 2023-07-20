require 'rails_helper'

describe 'User upload keywords file', type: :feature do
  let(:user) { create(:user) }

  context 'when user doesn\'t loged in' do
    before do
      visit keywords_upload_path
    end

    it 'should redirect to login page' do
      expect(page).to have_content('Log in')
    end
  end

  context 'when user upload file successfully' do
    before do
      login_as(user)
      visit keywords_upload_path
    end

    it 'should show error message' do
      within("form[action=\"#{keywords_upload_path}\"]") do
        attach_file 'uploads[file]', Rails.root.join('keyword-samples-file.txt'), id: 'uploads[file]'
      end

      click_button 'Upload'

      expect(page).to have_current_path(keywords_path)
    end
  end
end