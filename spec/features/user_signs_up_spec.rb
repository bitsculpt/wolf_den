require 'spec_helper'

feature 'Sign up' do

  scenario 'signs people up with valid information' do
    visit new_user_registration_path

    within('form#new_user') do
      fill_in "Email", with: 'jmoon90@aol.com'
      fill_in "Password", with: 'applepie'
      fill_in "Password confirmation", with: 'applepie'
      click_on 'Sign up'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'error message with invalid or email exists' do
    visit new_user_registration_path

    within('form#new_user') do
      fill_in 'Email', with: 'jmoon90@aol.com'
      fill_in "Password", with: 'cherrypie'
      fill_in "Password confirmation", with: 'cherrypie'
      click_on 'Sign up'
    end

    visit destroy_user_session_path
    visit new_user_registration_path

    within('form#new_user') do
      fill_in 'Email', with: 'jmoon90@aol.com'
      fill_in "Password", with: 'cherrypie'
      fill_in "Password confirmation", with: 'cherrypie'
      click_on 'Sign up'
    end

    expect(page).to have_content 'Email has already been taken'
  end
end
