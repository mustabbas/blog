require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Testing update_counter method' do
    user = User.new(name: 'mustafa abbas', photo: 'photo', bio: 'bio', posts_counter: 5)
    user.save
    post = Post.new(title: 'Post 1', text: '1', user_id: user.id, comments_counter: 0, likes_counter: 0)
    post.save

    it 'should return 1' do
      comment = Comment.new(text: 'Comment 1', user_id: user.id, post_id: post.id)
      comment.save
      Comment.update_comments_counter(post.id)
      post = Post.find(post.id)
      expect(post.comments_counter).to eq(1)
    end
  end
end
