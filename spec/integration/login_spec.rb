require 'spec_helper'

RSpec.describe 'Login page', type: :system do
  describe 'login page' do
    before(:each) do
      visit new_user_session_path
    end

    it 'Can see the user name input' do
      expect(page).to have_field('username')
    end

    it 'Can see the password input' do
      expect(page).to have_field('password')
    end

    it 'Can see the submit button' do
      expect(page).to have_button('Log in')
    end

    it 'When I click the submit button without filling in the username and the password,
    I get a detailed error.' do
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'When I click the submit button after filling in the username and the password with incorrect data,
    I get a detailed error.' do
      fill_in 'username', with: 'user@example.com'
      fill_in 'password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'When I click the submit button after filling in the username and the password with correct data,
    I am redirected to the root page.' do
      visit new_user_session_path
      fill_in 'username', with: 'abbas@gmail.com'
      fill_in 'password', with: '123456'
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end