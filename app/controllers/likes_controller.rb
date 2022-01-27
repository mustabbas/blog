class LikesController < ApplicationController
  def create
    like = Like.new(user_id: params[:user_id], post_id: params[:id])
    like.save
    Like.update_likes_counter(params[:id])
    redirect_to all_posts_path(params[:user_id])
  end
end
