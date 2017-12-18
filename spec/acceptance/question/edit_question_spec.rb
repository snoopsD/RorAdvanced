require 'acceptance_helper'

feature 'Editing question', %q{
  In order to fix mistake
  As an author question
  I want to be able to edit my question
} do

  given(:user)         { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question)    { create(:question, user: user) }
  given!(:another_question)    { create(:question, user: another_user) }

  scenario 'NonAuthenticated user try edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link to edit answer' do
      within '.edit-question' do
        expect(page).to have_link 'Edit question'
      end
    end

    scenario 'try edit own question', js: true do
      click_on 'Edit question'
      within '.edit-question' do
        fill_in 'Question title', with: 'edited question title'
        fill_in 'Question body', with: 'edited question body'
        click_on 'Save question' 
      end
      
      expect(page).to_not have_content question.title
      expect(page).to_not have_content question.body     
      expect(page).to have_content 'edited question title'
      expect(page).to have_content 'edited question body'
    end

    scenario 'try edit not own question', js: true do
      visit question_path(another_question)

      within '.question-data' do
        expect(page).to_not have_link 'Edit question'
      end
    end

  end
end
