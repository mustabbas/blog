class Post < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.update_posts_counter(author_id)
    u = User.find(author_id)
    u.posts_counter += 1
    u.save
  end

  def recent_comments(post_id)
    Commit.where(post_id: post_id).limit(5).order(created_at: :asc)
  end
end
