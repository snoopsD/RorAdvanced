require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete
  As a user
  I want to be able to delete own answer
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given(:question)   { create(:question, user: user)  }
  given!(:answer)    { create(:answer, question: question, user: user) }

  scenario 'Authenticated user delete own answer' do
    sign_in(user)

    visit question_path(question)

    click_on 'Delete answer'
    expect(page).to have_content 'Your answer deleted.'
    expect(page).to_not have_content 'Test answer'
  end

  scenario 'Authenticated user delete not own answer' do
    sign_in(other_user)

    visit question_path(question)

    expect(page).to_not have_content 'Delete answer'
  end

  scenario 'NonAuthenticated user try delete answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete answer'
  end
end
