require 'acceptance_helper'

feature 'Delete files to question', %q{
  In order ti illustrate my question
  As user
  I want to be delete attach files  
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given(:question)   { create(:question, user: user)  }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'Non Authenticated user cant delete files question' do
    visit question_path(question)

    expect(page).to_not have_link "Edit question"
  end
  
  scenario 'Authenticated user cant delete not own files question ' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to_not have_link "Edit question"
  end

  scenario 'Authenticated user can delete own file question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.edit-question' do
      click_on "Edit question"
      click_on "remove"    

      expect(page).to_not have_content attachment.file.identifier
    end
  end 
end  
