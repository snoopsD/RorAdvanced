require 'acceptance_helper'

feature 'Add files to answer', %q{
 In order to illustrate my answer
 As an author answer's
 I'd like to be able attach files  
} do

 given(:user) { create(:user) }
 given(:question) { create(:question, user: user) } 
 
 background do
   sign_in(user)
   visit question_path(question)
 end
 
 scenario 'User add files when ask answer', js: true do
  fill_in 'Answer', with: 'Test answer'
  attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

  click_on 'Answer send'
  
  within '.answers' do
   expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end 
 end 

 scenario 'User add multiple files  when ask answer', js: true do
  fill_in 'Answer', with: 'Test answer'
  attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

  click_on 'Add files'
  
  within all('.nested-fields').last do
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"     
  end  
  

  click_on 'Answer send'   

  within '.answers' do
   expect(page).to have_link 'spec_helper.rb'
   expect(page).to have_link 'rails_helper.rb'
  end 
 end  
end 


