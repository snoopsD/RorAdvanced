require 'acceptance_helper'

feature 'Editing answer', %q{
  In order to fix mistake
  As an author answer
  I want to be able to edit my answer
} do

  given(:user)         { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question)    { create(:question, user: user) }
  given!(:another_question)    { create(:question, user: user) }
  given!(:answer)      { create(:answer, question: question, user: user) }
  given!(:another_answer)    { create(:answer, question: another_question, user: another_user) }


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
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try edit own answer', js: true do
      within '.answer-edit' do
        click_on 'Edit'      
        fill_in 'Answer', with: 'edited answer'
      end  
      click_on 'Save'        
            
      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer'
    end

    scenario 'try edit not own answer', js: true do
      visit question_path(another_question)     
   
      within '.answers' do        
        expect(page).to_not have_link 'Edit'
        expect(page).to_not have_selector 'textarea[answer_body]'
      end
      
    end
  end
end
