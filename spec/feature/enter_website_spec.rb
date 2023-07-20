require 'rails_helper'

describe 'Enter website', type: :feature do
  scenario 'without sign in' do
    visit root_path

    expect(page).to have_content('Sign in')
  end
end
