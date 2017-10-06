require 'acceptance_helper'

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

    "#{answers.each {|answer| expect(page).to have_content answer.body } }"
  end
end
