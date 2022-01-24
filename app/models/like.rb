class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    def update_like_count(post_id)
        post = Post.find_by(post_id)
        post.update(likes_counter: likes_counter+1)
    end
end
