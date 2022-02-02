require 'rails_helper'

RSpec.describe 'Users Post Index Page', type: :system do

  def visit_post_index_path(user_id)
    visit user_posts_path(user_id: user_id)
  end

  def create_post_and_visit_path
    post = User.first.posts.first
    visit_post_index_path post.user
    post
  end

  def visit_comments_page_and_create_comment(post)
    visit new_user_post_comment_path(user_id: post.author, post_id: post.id)
    fill_in 'Text', with: 'This is awsome!'
    click_button 'Create'
  end

  describe 'Users Post Index Page' do
    before(:each) do
      visit new_user_session_path
      fill_in 'username', with: 'abbas@gmail.com'
      fill_in 'password', with: '123456'
      click_button 'Log in'
    end
    it 'Can see the profile image' do
      create_post_and_visit_path
      image = page.find('img', id: "profile-image#{User.first.id}")
      expect(image['src']).to have_content 'profile_icon'
    end

    it "Can see the user's name" do
      expect(page).to have_content 'abbas'
    end

    it 'Can see the number of posts' do
      visit user_posts_path(user_id: User.first.id)
      expect(page).to have_content 'Number of posts: 4'
    end

    it "Can see a post's title." do
      create_post_and_visit_path
      expect(page).to have_content 'tt'
    end

    it "Can see some of the post's body" do
      create_post_and_visit_path
      expect(page).to have_content Post.all[0].text
    end

    it 'Can see the first comments on a post.' do
      post = create_post_and_visit_path
      6.times { visit_comments_page_and_create_comment post }
      visit user_posts_path(user_id: post.author)
      expect(page).to have_content 'This is awsome!'
    end

    it 'Can see how many comments a post has' do
      post = create_post_and_visit_path
      6.times { visit_comments_page_and_create_comment post }
      visit user_posts_path(user_id: post.author)
      expect(page).to have_content 'Comments: 6'
    end

    it 'Can see how many likes a post has.' do
      post = create_post_and_visit_path
      visit user_post_path(user_id: post.author, id: post.id)
      like_button = page.find('button', class: 'like-button')
      3.times do
        sleep(1)
        like_button.click
      end
      visit user_posts_path(user_id: post.author)
      expect(page).to have_content 'Likes: 3'
    end

    it 'Can see a section for pagination if there are more posts than fit on the view' do
      post = create_post
      10.times { create_post }
      visit_post_index_path post.author
      expect(page).to have_link 'pagination'
    end

    it "Redirects me to that post's show page when I click on a post, " do
      post = create_post
      visit_post_index_path post.author
      post_preview = page.all('a', class: 'post-preview-link')[1]
      post_preview.click
      expect(page).to have_current_path user_post_path(user_id: post.author, id: post.id)
    end
  end
end