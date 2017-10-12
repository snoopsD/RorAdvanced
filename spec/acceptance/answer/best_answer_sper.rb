require 'acceptance_helper'

feature 'check best answer', %q{
  In order to check best answer
  As an author question
  I want to be check
} do

  given(:user)       { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question)   { create(:question, user: user) }
  given!(:answer)    { create_list(:answer, 2, question: question, user: user) }

  scenario 'NonAuthethicated user cant sees to check best answer' do
    visit question_path(question)

    expect(page).to_not have_selector(:button, 'best')
  end

  scenario 'Authethicated cant sees to check best answer', js: true do
    sign_in(other_user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_selector(:button, 'best')
    end
  end

  describe 'Authethicated user ' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can sees to check best answer', js: true do
      within '.answers' do
        expect(page).to have_selector(:button, 'best'), count: 2

      end
    end

    scenario 'can choose the best answer', js: true do
      within "#answer-#{answer.last.id}" do
        click_on 'best'
      end

      within ".best-answer" do
        expect(current_path).to eq question_path(question)
        expect(page).to have_content "#{answer.last.body}"
        expect(page).to_not have_content "#{answer.first.body}"
      end
    end

    scenario 'can choose another answer for best check', js: true do
      within "#answer-#{answer.first.id}" do
        click_on 'best'
      end

      within ".best-answer" do
        expect(current_path).to eq question_path(question)
        expect(page).to have_content "#{answer.first.body}"
        expect(page).to_not have_content "#{answer.last.body}"
      end
    end
  end
end
