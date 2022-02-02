require 'rails_helper'

def create_test_users
  before(:each) do
    visit new_user_session_path
    fill_in 'username', with: 'abbas@gmail.com'
    fill_in 'password', with: '123456'
    click_button 'Log in'
  end
end

RSpec.describe 'User index page', type: :system do
  describe 'I can see the username of all other users' do
    create_test_users
    it 'Can see the user name mustafa' do
      expect(page).to have_content('mustafa')
    end

    it 'Can see the user name abbas' do
      expect(page).to have_content('abbas')
    end

    it 'Can see the username tt' do
      expect(page).to have_content('tt')
    end
  end

  describe 'I can see the profile picture for each user' do
    create_test_users
    it 'test image for first user' do
      image = page.find('img', id: "profile-image#{User.all[0].id}")
      expect(image['src']).to have_content 'profile_icon'
    end

    it 'test image for second user' do
      image = page.find('img', id: "profile-image#{User.all[1].id}")
      expect(image['src']).to have_content 'profile_icon'
    end

    it 'test image for third user' do
      image = page.find('img', id: "profile-image#{User.all[2].id}")
      expect(image['src']).to have_content 'profile_icon'
    end
  end

  describe 'can see the number of posts each user has written' do
    create_test_users
    it 'can see that first users posts are 3' do    
      visit user_path
      expect(User.find_by(email: 'abbas@gmail.com').posts_counter).to eq 3
    end

    it 'can see that second users posts are 0' do
      visit user_path
      expect(User.find_by(email: 'dyary2020@gmail.com').posts_counter).to eq 0
    end
  end

  describe 'When I click on a user, I am redirected to that user\'s show page' do
    create_test_users
    it 'redirects to when clicked' do
      id = User.all[0].id
      link = page.all("a")[0]
      link.click
      expect(page).to have_current_path(user_show_path(id))
    end
  end
end