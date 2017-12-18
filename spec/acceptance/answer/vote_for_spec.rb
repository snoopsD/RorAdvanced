require 'acceptance_helper'

feature 'vote for question', %q{
  In order to vote
  As an user
  I want to be able vote for answer
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question)  { create(:question, user: user)  }
  given!(:answer)     { create(:answer, question: question, user: user) }

  scenario 'Author try vote for own answer ', js: true do
    sign_in(user)
    visit question_path(question)    

    within '.a-vote' do
      expect(page).to_not have_button '+'
    end  
  end  

  describe 'Authenticated user' do
    before do 
      sign_in(other_user)
      visit question_path(question)
    end   

    scenario 'Authenticated user sees button vote for not own answer ', js: true do     
      within '.a-vote' do
        expect(page).to have_button '+'    
      end  
    end  

    scenario 'Authenticated user try vote for not own answer ', js: true do  
      within '.a-vote' do    
        click_on '+'  
        expect(page).to have_content "1"  
      end    
    end  

    scenario 'Authenticated user try negative vote for not own answer ', js: true do
      within '.a-vote' do
        click_on '-'  
        expect(page).to have_content "-1"  
      end    
    end  

    scenario 'Authenticated user cancel vote for not own answer ', js: true do
      within '.a-vote' do
        click_on '+'  
        expect(page).to have_content "1"   
      
        click_on '-'
        expect(page).to have_content "0"      
      end  
    end 
  end   

  scenario 'NonAuthenticated user try vote for answer' do
    visit question_path(question)

    within '.a-vote' do
      expect(page).to_not have_button '+'
    end  
  end  


end  