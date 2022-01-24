class Post < ApplicationRecord
    belongs_to :user
    has_many :commit, foreign_key: 'post_id'
    has_many :like, foreign_key: 'post_id'
    def update_posts_count(author_id)
        user = find_by(author_id)
        user.update(posts_counter: posts_counter+1)
    end

    def recent_comments(post_id)
        Commit.where(post_id: post_id).limit(5).order(created_at: :asc)
    end
end
