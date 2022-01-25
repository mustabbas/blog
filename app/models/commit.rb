class Commit < ApplicationRecord
  belongs_to :user
  belongs_to :post
  def update_comments_count(post_id)
    post = Post.find_by(post_id)
    post.update(comments_counter: comments_counter + 1)
  end
end
