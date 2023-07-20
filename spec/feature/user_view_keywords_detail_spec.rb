require 'rails_helper'

describe 'User view keywords detail', type: :feature do
  include ActionView::TestCase::Behavior

  let(:keyword) { create(:keyword, html: '<h1>foo</h1>') }
  let(:user) do
    create(:user)
  end

  context 'when user doesn\'t loged in' do
    before do
      visit keyword_path(keyword)
    end

    it 'should redirect to login page' do
      expect(page).to have_content('Log in')
    end
  end

  context 'when keyword is not found' do
    before do
      login_as(user)
      visit keyword_path(-1)
    end

    it 'should render not found' do
      expect(page).to have_content('No keyword found.')
    end
  end

  context 'when keywords is found' do
    subject { keyword }
    before do
      create(:user_keyword, user:, keyword: subject)
      login_as(user)

      visit keyword_path(subject)
    end

    it 'should show total adwords' do
      expect(page).to have_content("Total Adwords #{number_with_delimiter(subject.total_adword)}")
    end

    it 'should show total links' do
      expect(page).to have_content("Total Links #{number_with_delimiter(subject.total_link)}")
    end

    it 'should show total results' do
      expect(page).to have_content("Total Results #{number_with_delimiter(subject.total_result)}")
    end

    it 'should show total search times' do
      expect(page).to have_content("Total Search Times #{number_with_delimiter(subject.total_search_time)}")
    end

    it 'should show cached page' do
      expect(page).to have_css("iframe[srcdoc=\"#{subject.html}\"]")
    end
  end
end
