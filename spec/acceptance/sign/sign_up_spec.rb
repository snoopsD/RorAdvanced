require 'rails_helper'

feature 'user can sign up', %q{
  In order to create account
  As an user
  I want to be sign up
} do

  scenario 'Register new user with valid data' do

    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: 'user@test.ru'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(current_path).to eq root_path
  end

  scenario 'Register new user with invalid data' do

    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: 'user@test.ru'
    fill_in 'Password', with: nil
    fill_in 'Password confirmation', with: nil
    click_on 'Sign up'

    expect(page).to have_content 'Password can\'t be blank'
  end


end
