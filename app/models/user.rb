class User < ApplicationRecord
  has_many :posts, foreign_key: 'user_id'
  has_many :commit, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'

  def self.recent_posts(user_id)
    Post.where(user_id: user_id).limit(3).order(created_at: :asc)
  end
end
