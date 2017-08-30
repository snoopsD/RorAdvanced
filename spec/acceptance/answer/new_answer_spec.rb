require 'rails_helper'

feature 'create answer on question', %q{
  In order to create answer to question
  As an authencate user
  I want to be able send answer
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given(:question)   { create(:question, user: user) }

  scenario 'Authethicated user can answer to question' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Answer', with: 'Test answer'
    click_on 'Answer send'

    expect(current_path).to eq question_path(question)
    expect(page). to have_content 'Your answer created'
    expect(page). to have_content 'Test answer'
  end

  scenario 'Non-Authethicated user cant answer to question' do
    visit questions_path(question)
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
