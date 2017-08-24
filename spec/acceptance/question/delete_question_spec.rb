require 'rails_helper'

feature 'Delete question', %q{
  In order to delete
  As a user
  I want to be able to delete my question
} do

  given(:user)       { create(:user) }
  given(:question)   { create(:question, user: user)  }

  scenario 'Authenticated user delete own question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Your question succefully deleted.'
    expect(page).to_not have_content question.title
  end

end
