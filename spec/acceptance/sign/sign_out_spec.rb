require 'rails_helper'

feature 'user sig out', %q{
  In order to be able logut
  As an user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Registered user try to sign out' do
    sign_out(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end
end
