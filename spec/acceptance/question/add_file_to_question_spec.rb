require 'acceptance_helper'

feature 'Add files to question', %q{
  In order ti illustrate my question
  As an author question's
  I'd like to be able attach files  
} do

  given( :user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end
  
  scenario 'User add files when ask question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.attachments_question' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end  
  end 

  scenario 'User add multiple files when ask question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Add files'
    within all('.nested-fields').last do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end  
    
    click_on 'Create'  
    
    
    within '.attachments_question' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end  
  end  

end 



