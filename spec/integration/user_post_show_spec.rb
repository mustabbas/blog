require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'Post show' do
    before(:each) do
      visit new_user_session_path
      fill_in 'username', with: 'abbas@gmail.com'
      fill_in 'password', with: '123456'
      click_button 'Log in'
      visit posts_show_path(user_id: User.first,
                            post_id: User.first.posts.first)
    end
    it "I can see the post's title." do
      expect(page).to have_content('XZC')
    end
    it 'I can see who wrote the post.' do
      expect(page).to have_content('by mustafa')
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content('comments: 1')
    end
    it 'I can see how many likes it has.' do
      expect(page).to have_content('likes: 0')
    end
    it 'I can see the post body.' do
      expect(page).to have_content('ZXC')
    end
    it 'I can see the username of each commentor.' do
      expect(page).to have_content(User.first.posts.first.comments.first.user.name)
    end
    it 'I can see the comment each commentor left.' do
      expect(page).to have_content(User.first.posts.first.comments.first.text)
    end
  end
end
