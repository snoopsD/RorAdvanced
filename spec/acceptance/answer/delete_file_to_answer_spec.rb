require 'acceptance_helper'

feature 'Delete files to answer', %q{
  In order to fix my answer
  As user
  I want to be delete attach files  
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question)   { create(:question, user: user)  }
  given!(:answer)   { create(:answer, question: question, user: user)  }
  given!(:attachment) { create(:attachment, attachable: answer) }
  
  scenario 'Non Authenticated user cant delete files answer' do
    visit question_path(question)

    expect(page).to_not have_link "Edit answer"
  end

  scenario 'Authenticated user cant delete not own files answer' do
    sign_in(other_user)
    visit question_path(question)   

    expect(page).to_not have_link "Edit answer"
  end
  
  scenario 'Authenticated user can delete own files answer', js: true do
    sign_in(user)
    visit question_path(question)
    #sleep(3000)
    within '.answers' do
      
      click_on 'Edit'
      
      click_on 'remove'
      
      click_on 'Save' 
           

      expect(page).to_not have_content attachment.file.identifier      
    end
  end  
end  
