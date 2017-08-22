require 'rails_helper'

feature 'view question', %q{
  In order to get questions
  As an user
  I want to be view questions
} do

  given!(:questions) { create_list(:question, 3) }

  scenario 'All users view questions' do
    visit questions_path
  end

end
