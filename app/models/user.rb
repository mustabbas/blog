class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :commit, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def self.recent_posts(author_id)
    Post.where(author_id: author_id).limit(3).order(created_at: :asc)
  end
end
