require 'rails_helper'

RSpec.describe 'Show page', type: :system do
  describe 'show page' do
    before(:each) do
      visit new_user_session_path
      fill_in 'username', with: 'abbas@gmail.com'
      fill_in 'password', with: '123456'
      click_button 'Log in'
      id = User.first.id
      visit user_show_path(id)
    end
    it 'Can see the profile image' do
      image = page.find('img', id: "profile-image#{User.first.id}")
      expect(image['src']).to have_content 'profile_icon'
    end
    it "Can see the user's name" do
      expect(page).to have_content 'mustafa'
    end
    it 'Can see the number of posts' do
      visit user_show_path(User.first.id)
      expect(page).to have_content 'Number of posts : 5'
    end
    it "I can see the user's bio." do
      expect(page).to have_content User.first.bio
    end
    it "I can see the user's first 3 posts." do
      visit user_show_path(User.first.id)
      post = page.all('div', class: 'post-preview')
      expect(post.count).to eq(3)
    end
    it "I can see a button that lets me view all of a user's posts." do
      expect(page).to have_button('see all post')
    end
    it "When I click a user's post, it redirects me to that post's show page." do
      visit user_show_path(User.first.id)
      user_id = User.first.id
      post_id = User.first.posts.first
      link = page.all('a', class: 'post-preview-link')[0]
      link.click
      expect(page).to have_current_path(posts_show_path(user_id: user_id, post_id: post_id))
    end
    it "When I click to see all posts, it redirects me to the user's post's index page." do
      visit user_show_path(User.first.id)
      user_id = User.first.id
      click_button 'see all posts'
      expect(page).to have_current_path(all_posts_path(id: user_id))
    end
  end
end