require 'rails_helper'

describe 'User searchs keywords', type: :feature do
  let(:user) { create(:user) }

  let(:keyword1) { create(:keyword, word: 'Apple') }
  let(:keyword2) { create(:keyword, word: 'Boat') }
  let(:keyword3) { create(:keyword, word: 'Cat') }

  before do
    create(:user_keyword, user:, keyword: keyword1)
    create(:user_keyword, user:, keyword: keyword2)
    create(:user_keyword, user:, keyword: keyword3)
  end

  context 'when user doesn\'t loged in' do
    before do
      visit keywords_path
    end

    it 'should redirect to login page' do
      expect(page).to have_content('Log in')
    end
  end

  context 'when keywords are not match' do
    before do
      login_as(user)
      visit keywords_path

      within('form[action="/keywords"]') do
        fill_in 'q', with: 'YOLO'
      end
      click_button 'Search'
    end

    it 'should show empty message' do
      expect(page).to have_content('No keywords found.')
    end
  end

  context 'when keywords are match' do
    before do
      login_as(user)
      visit keywords_path
      within('form[action="/keywords"]') do
        fill_in 'q', with: 'ap'
      end

      click_button 'Search'
    end

    it 'should show keyword list' do
      expect(page).to have_link(keyword1.word)
    end
  end
end
