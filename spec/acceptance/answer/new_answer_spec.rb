require 'rails_helper'

feature 'create answer on question', %q{
  In order to create answer to question
  As an authencate user
  I want to be able send answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authethicated user can answer to question' do
    sign_in(user)
    visit questions_path(question)
    click_on "MyString"
    fill_in 'Answer', with: 'Test answer'
    click_on 'Answer send'

    expect(page). to have_content 'Your answer created'
  end

  scenario 'Non-Authethicated user cant answer to question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
