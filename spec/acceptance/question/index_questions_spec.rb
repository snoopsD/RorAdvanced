require 'acceptance_helper'

feature 'view question', %q{
  In order to get questions
  As an user
  I want to be view questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  scenario 'All users view questions' do
    visit questions_path

    expect(page).to have_content('MyString', count: 3)
  end

end
