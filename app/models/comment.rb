class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_comments_counter(post_id)
    p = Post.find(post_id)
    p.comments_counter += 1
    p.save
  end
end
