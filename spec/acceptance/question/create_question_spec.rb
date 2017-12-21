require 'acceptance_helper'

feature 'create question', %q{
  In order to get answer from community
  As an authencate user
  I want to be able ask questions
} do

  given(:user) { create(:user) }

  scenario 'Authethicated user create question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'   
   
    click_on "Create"

    expect(page).to have_content 'Your question succefully created.'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text text'
  end

  scenario 'Authethicated user create question with invalid params' do
    sign_in(user)

    visit questions_path
    
    click_on 'Ask question'
    fill_in 'Title', with: nil
    fill_in 'Body', with: nil
    
    click_on 'Create'

    expect(page).to have_content 'Body can\'t be blank'
    expect(page).to have_content 'Title can\'t be blank'
  end

  describe "multiple session" do
    scenario "question appears an another user page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end  

      Capybara.using_session('guest') do
        visit questions_path        
      end  

      Capybara.using_session('user') do
        click_on 'Ask question'
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'text text'   
       
        click_on "Create"
        expect(page).to have_content 'Your question succefully created.'
        expect(page).to have_content 'Test question'
        expect(page).to have_content 'text text'
      end 
      
      Capybara.using_session('user') do
        expect(page).to have_content 'Test question'
      end  
    end  
  end  

  scenario 'Non-Authethicated user create question' do
    visit questions_path
    
    click_on 'Ask question'    

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
