require 'rails_helper'

feature 'create answer on question', %q{
  In order to create answer to question
  As an authencate user
  I want to be able send answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  scenario 'view questions and answers' do
    visit questions_path(question)
    click_on "MyString"

    expect(page).to have_content ("MyTextTextText1")
    expect(page).to have_content ("MyTextTextText2")
    expect(page).to have_content ("MyTextTextText3")
  end
end
