require 'rails_helper'

describe 'User view list of keywords', type: :feature do
  let(:keywords) { create_list(:keyword, 3) }
  let(:user) do
    create(:user)
  end

  context 'when user doesn\'t loged in' do
    before do
      visit keywords_path
    end

    it 'should redirect to login page' do
      expect(page).to have_content('Log in')
    end
  end

  context 'when keywords are empty' do
    before do
      login_as(user)
      visit keywords_path
    end

    it 'should show empty message' do
      expect(page).to have_content('No keywords found.')
    end
  end

  context 'when keywords are not empty' do
    before do
      login_as(user)
      keywords.each { |keyword| create(:user_keyword, user:, keyword:) }

      visit keywords_path
    end

    it 'should show keyword list' do
      expect(page).to have_link(keywords[0].word)
      expect(page).to have_link(keywords[1].word)
      expect(page).to have_link(keywords[2].word)
    end
  end
end
