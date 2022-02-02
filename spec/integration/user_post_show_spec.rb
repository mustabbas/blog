require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'Post show' do
    before(:each) do
      user1 = User.new(name: 'Luis', email: 'luis@gmail.com', password: '123456', photo: 'image1',
                       bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
      user1.save
      user2 = User.new(name: 'Octavio', photo: 'image2',
                       bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                       posts_counter: 0, email: 'octavio@gmail.com', password: '123456')
      user2.save
      visit new_user_session_path
      fill_in 'Username', with: 'luis@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      post = User.find_by(email: 'luis@gmail.com').posts.new(
        title: 'New post 1',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        comments_counter: 0, likes_counter: 0
      )
      post.save
      User.all[1].comments.create!(text: 'Well Done 👏👏👏', post: Post.all[0])
      User.all[1].comments.create!(text: 'really nice post Luis', post: Post.all[0])
      Like.create!(author: User.all[1], post: Post.all[0])
      visit user_post_path(user_id: User.find_by(email: 'luis@gmail.com').id,
                           id: User.find_by(email: 'luis@gmail.com').posts.first.id)
    end
    it "I can see the post's title." do
      expect(page).to have_content('New post 1')
    end
    it 'I can see who wrote the post.' do
      expect(page).to have_content('by Luis')
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content('Comments: 2')
    end
    it 'I can see how many likes it has.' do
      expect(page).to have_content('Likes: 1')
    end
    it 'I can see the post body.' do
      expect(page).to have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    end
    it 'I can see the username of each commentor.' do
      expect(page).to have_content(User.all[1].name)
    end
    it 'I can see the comment each commentor left.' do
      expect(page).to have_content(User.all[1].comments.all[0].text)
    end
  end
end