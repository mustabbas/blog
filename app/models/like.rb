class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_likes_counter(post_id)
    p = Post.find(post_id)
    p.likes_counter += 1
    p.save
  end
end
