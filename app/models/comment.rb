class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_comments_counter(post_id)
    p = Post.find(post_id)
    p.comments_counter = p.comments.length
    p.save
  end
end
