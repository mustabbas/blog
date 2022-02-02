require 'rails_helper'

RSpec.describe 'Login page', type: :system do
  describe 'login page' do
    before(:each) do
      User.create(name: 'Luis', email: 'luis@gmail.com', password: '123456', photo: 'image1',
                  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                  Nulla aliquet et lorem at volutpat. Aenean vel justo diam.
                  Vivamus ultricies vulputate dolor, et molestie turpis convallis et.
                  In sed metus.', posts_counter: 0)
      visit new_user_session_path :host => 'localhost:3000'
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
      fill_in 'Username', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'When I click the submit button after filling in the username and the password with correct data,
    I am redirected to the root page.' do
      fill_in 'Username', with: 'luis@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
    end
  end
end