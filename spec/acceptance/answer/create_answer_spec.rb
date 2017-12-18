require 'acceptance_helper'

feature 'create answer on question', %q{
  In order to create answer to question
  As an authencate user
  I want to be able send answer
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question)   { create(:question, user: user) }

  scenario 'Authethicated user can answer to question', js: true do
    sign_in(user)
    visit question_path(question)
  
    fill_in 'Answer', with: 'Test answer create'

    click_on 'Answer send'  

    expect(current_path).to eq question_path(question)
    
    expect(page).to have_content 'Your answer created'
    within '.answers' do
      expect(page).to have_content 'Test answer create'
    end
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Answer send'

    expect(page).to have_content "Body is too short (minimum is 5 characters)"
  end

  scenario 'Non-Authethicated user cant answer to question', js: true do
    visit questions_path(question)
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
