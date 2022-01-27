class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  def update_posts_count(user_id)
    user = find_by(user_id)
    user.update(posts_counter: posts_counter + 1)
  end

  def recent_comments(post_id)
    Commit.where(post_id: post_id).limit(5).order(created_at: :asc)
  end
end
